class Promo < ActiveRecord::Base
  has_many :orders

  before_validation :promo_gen

  validates :name, length: {in: 3..15}, uniqueness: true
  validates :sale, numericality: {greater_than_or_equal_to: 0}
  validates :quantity, numericality: {greater_than_or_equal_to: 0}

  def promo_gen
    mask = self.name
    string = ""
    mask.each_char do |c|
      if c == '@'
        string << ('a'..'z').to_a[rand(26)]
      elsif c == '#'
        string << rand(10).to_s
      elsif c == '*'
        astr = rand(2)
        if astr == 1
    	     string << ('a'..'z').to_a[rand(26)]
        else
    	     string << rand(10).to_s
        end
      else
        string << c
      end
    end
    self.name = string.upcase
  end
end
