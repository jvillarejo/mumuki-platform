class ImportSubmissionsFromGitJob
  include SuckerPunch::Job

  def perform(batch_id)
    ActiveRecord::Base.connection_pool.with_connection do
      batch = ::SubmissionBatch.find(batch_id)
      batch.import_submissions!
    end
  end

end