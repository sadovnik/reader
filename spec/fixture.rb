# Helps to extract fixtures located locally
#
# How this works. Suppose we're in `project/spec/foo_spec.rb`:
#
# fixture = Fixture.new(File.expand_path(__FILE__))
#
# fixture.get('bar.xml')
# => <contents of project/spec/fixtures/foo/bar.xml>
class Fixture
  def initialize(test_file_path)
    @test_file_path = test_file_path
  end

  def get(fixture)
    File.read(fixture_path(fixture))
  end

  private

  def fixture_path(fixture)
    File.expand_path("./fixtures/#{spec_name}/#{fixture}", directory_name)
  end

  def spec_name
    File.basename(@test_file_path, '_spec.rb')
  end

  def directory_name
    File.dirname(@test_file_path)
  end
end
