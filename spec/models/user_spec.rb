require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Timothy', bio: 'Hello! new user here', photo: 'https://dropbox/users/timothy/profilepic.webp') }

  it 'Name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Post counter should have a value greater than or equal to zero' do
    subject.post_counter = -1
    expect(subject).to_not be_valid
  end

  it 'Recent post method should return three most recent post' do
    Post.create(author: subject, title: 'String', text: 'Text')
    Post.create(author: subject, title: 'String', text: 'Text')
    Post.create(author: subject, title: 'String', text: 'Text')

    expect(subject.recent_posts.length).to eq(3)
  end
end
