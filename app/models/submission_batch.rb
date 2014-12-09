class SubmissionBatch < ActiveRecord::Base
  include ImportFromGit

  belongs_to :submitter, class_name: 'User'

  validates_presence_of :git_url, :submitter

  after_commit :schedule_submissions_import!, on: :create

end
