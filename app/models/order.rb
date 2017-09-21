class Order < ActiveRecord::Base
  belongs_to :promo
  belongs_to :user

  validates :description, length: {in: 3..128}
  validates :price, numericality: {greater_than_or_equal_to: 0}
  validate :promo_input_is_exist?

  before_create :set_promo_id_and_set_promo_quantity

  def promo_input_is_exist?
    unless promo_input.empty?
      a = Promo.all.select {|x| x.name == self.promo_input}
      if a.empty?
        errors.add(:promo_input, "такого промокода не существует")
      elsif a.first.quantity == 0
        errors.add(:promo_input, "время использования промокода истекло")
      end
    end
  end

  def set_promo_id_and_set_promo_quantity
    a = Promo.all.select {|x| x.name == self.promo_input}.first
    unless a.nil?
      self.promo_id = a.id
      a.quantity -= 1
      a.save
    end
  end
end
