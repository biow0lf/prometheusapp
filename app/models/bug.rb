class Bug < ActiveRecord::Base
  validates_presence_of :bug_id
  validate :uniqueness_of_bug_id

  def uniqueness_of_bug_id
    errors.add(:uniq, "should be uniq") if Bug.count(:all, :conditions => {
                                                             :bug_id => bug_id } ) == 1
  end

  def self.update_bugs_from_bugzilla_alt(url)
    ActiveRecord::Base.transaction do
      Bug.delete_all
      #url = "https://bugzilla.altlinux.org/buglist.cgi?ctype=csv"
      csv = CSV.parse(open(URI.escape(url)).read)

      csv.each do |row|
        if row[0] != 'bug_id'
          bug = Bug.new
          bug.bug_id = row[0]
          bug.bug_status = row[1]
          if row[2] != nil
            bug.resolution = row[2]
          else
            bug.resolution = ''
          end
          bug.bug_severity = row[3]
          bug.product = row[4]
          bug.component = row[5]
          bug.assigned_to = row[6]
          bug.reporter = row[7]
          bug.short_desc = row[8]
          bug.save!
        end # if row[0] != 'bug_id'
      end # cvs.each
    end
  end

end
