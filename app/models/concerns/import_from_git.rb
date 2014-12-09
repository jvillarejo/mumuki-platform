require 'git'

module ImportFromGit

  def schedule_submissions_import!
    ImportSubmissionsFromGitJob.new.async.perform(id)
  end

  def import_submissions!
    Dir.mktmpdir("mumuki.#{submitter_id}.import") do |dir|
      Git.clone(git_uri, 'name', dir)
      Dir.glob("#{dir}/**/submissions/*") do |file|
        create_submission_for!(file)
      end
    end
  end

  def create_submission_for!(file)
    exercise_id = exercise_id_for(file)
    exercise = Exercise.find(exercise_id)
    exercise.submissions.create!(submitter: submitter, content: File.read(file))
  end

  def exercise_id_for(file)
    /(\d+)(_.*\..*)?/.match(file.name).captures[0].to_i
  end
end