#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class Stock < ActiveRecord::Base
  attr_accessible :picture
  has_attached_file :picture, :styles => { :medium => "300x150>", :thumb => "100x50>" }

  has_many :orderdetails
  has_many :ordermains, through: :orderdetails
  #...

  #before_destroy :ensure_not_referenced_by_any_line_item

  attr_accessible :pid, :goodsname, :image_url, :pfprice, :goodsname
  validates :goodsname, :pid, presence: true
  validates :pfprice, numericality: {greater_than_or_equal_to: 0.01}
# 
  validates :pid, uniqueness: true
  # validates :image_url, allow_blank: true, format: {
  #   with:    %r{\.(gif|jpg|png)\Z}i,
  #   message: 'must be a URL for GIF, JPG or PNG image.'
  # }
  validates :goodsname, length: {minimum: 1}

  paginates_per 12
  def self.latest
    Stock.order('updated_at desc').limit(1).first
  end



  private

    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if orderdetails.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end
