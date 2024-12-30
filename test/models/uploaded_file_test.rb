require 'test_helper'

class UploadedFileTest < ActiveSupport::TestCase
  include ActionDispatch::TestProcess::FixtureFile

  def setup
    @uploaded_file = uploaded_files(:one)
    file = fixture_file_upload('test_image.jpg', 'image/jpeg')
    @uploaded_file.file.attach(file)
  end

  test "should be valid" do
    assert @uploaded_file.valid?
  end

  test "should have one attached file" do
    assert @uploaded_file.file.attached?
  end

  test "file should be present" do
    @uploaded_file.file = nil
    assert_not @uploaded_file.valid?
  end

  test "should validate mime type" do
    assert @uploaded_file.private_methods.include?(:correct_mime_type)
  end

  test "should allow valid mime types" do
    valid_mime_types = %w[image/png image/jpg image/jpeg application/pdf]
    assert_includes valid_mime_types, @uploaded_file.file.content_type
  end
end
