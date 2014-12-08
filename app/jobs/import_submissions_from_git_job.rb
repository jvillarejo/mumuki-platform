require 'tempfile'
require 'git'

class ImportSubmissionsFromGitJob
  include SuckerPunch::Job

  def perform(user_id, git_uri)
    ActiveRecord::Base.connection_pool.with_connection do
      user = ::User.find(user_id)
      Dir.mktmpdir("mumuki.#{user_id}.import") do |dir|
        Git.clone(git_uri, 'name', dir)
        Dir.glob("#{dir}/**/submissions/*") do |file|
          exercise_id = /(.*)_.*\..*/ =~ file.name
          exercise = Exercise.find(exercise_id)
          exercise.submissions.create!(submitter: user, content: File.read(file))
        end
      end
    end
  end
end