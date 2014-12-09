class CreateSubmissionBatches < ActiveRecord::Migration
  def change
    create_table :submission_batches do |t|
      t.string :git_url
      t.references :submitter

      t.timestamps
    end
  end
end
