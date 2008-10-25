require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe 'Snippets' do
  scenario :users
  
  before do
    login :admin
  end
  
  it 'should be able to go to snippets tab' do
    click_on :link => '/admin/snippets'
  end
  
  it 'should be able to create a new snippet' do
    navigate_to '/admin/snippets/new'
    lambda do
      submit_form :snippet => {:name => 'Mine', :content => 'Me Snippet'}
    end.should change(Snippet, :count).by(1)
  end
end

describe 'Snippet as resource' do
  scenario :users
  
  before do
    @snippet = Snippet.create!(:name => 'Snippet', :content => 'Content')
  end
  
  it 'should require authentication' do
    get "/admin/snippets/#{@snippet.id}.xml"
    response.headers.keys.should include('WWW-Authenticate')
  end
  
  it 'should reject invalid creds' do
    get "/admin/snippets/#{@snippet.id}.xml", nil, :authorization => encode_credentials(%w(admin badpassword))
    response.headers.keys.should include('WWW-Authenticate')
  end
  
  it 'should be obtainable by users' do
    get "/admin/snippets/#{@snippet.id}.xml", nil, :authorization => encode_credentials(%w(admin password))
    response.body.should match(/xml/)
  end
end