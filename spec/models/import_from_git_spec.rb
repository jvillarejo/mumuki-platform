require 'spec_helper'

describe ImportFromGit do
  include ImportFromGit

  describe 'exercise_id_for' do
    let(:simple_file) { OpenStruct.new(name: '45.hs') }
    let(:file_with_title) { OpenStruct.new(name: '45_recursive_map.hs') }

    it { expect(exercise_id_for(simple_file)).to equal(45) }
    it { expect(exercise_id_for(file_with_title)).to equal(45) }
  end

  describe 'create_submission_for!!' do
    let(:file) { Tempfile.for_content('foo', 'bar') }
    let(:submitter) { create(:user) }

    after { file.unlink }

    it { expect(create_submission_for!(file)) }
  end
end
