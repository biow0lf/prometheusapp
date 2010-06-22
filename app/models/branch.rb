class Branch < ActiveRecord::Base
  validates_presence_of :distribution, :vendor, :order_id
  validate :uniqueness_of_distribution_and_vendor

  def uniqueness_of_distribution_and_vendor
    errors.add(:uniq, "should be uniq") if Branch.count(:all, :conditions => {
                                                                :distribution => distribution,
                                                                :vendor => vendor } ) == 1
  end
end
