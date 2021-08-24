class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  def stock_already_tracked?(ticker_symbol)
    stock = Stock.db_lookup(ticker_symbol)
    return false unless stock
    stocks.where(id: stock.id).exists?
  end

  def under_stock_limit?
    stocks.count < 10
  end

  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  def not_friends_with?(friend_id)
    !self.friends.where(id: friend_id).exists?
  end

  def self.search(value)
    value.strip!
    search_results = (first_name_matches(value) + last_name_matches(value) + email_matches(value)).uniq
    return nil if search_results.empty?
    search_results
  end

  def self.first_name_matches(value)
    matches("first_name", value)
  end

  def self.last_name_matches(value)
    matches("last_name", value)
  end

  def self.email_matches(value)
    matches("email", value)
  end

  def self.matches(field, value)
    where("#{field} LIKE ?", "%#{value}%")
  end
end
