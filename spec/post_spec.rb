require_relative "../models/post.rb"
require "spec_helper"
require 'active_record'
require 'pry'

describe Post do
  it 'must have a title and a body' do
    expect(Post.new({})).to be_invalid
  end

  it 'must have a title' do
    expect(Post.new({body: 'Body'})).to be_invalid
  end

  it 'must have a body' do
     expect(Post.new({title: 'Title'})).to be_invalid
  end

  it 'has a valid title and body' do
    expect(Post.new({title: 'Title', body: 'Body'})).to be_valid
  end

  it 'saves a post correctly in the database' do
    blog_size_before_save = Post.all.size
    Post.new({title: 'Title', body: 'Body'}).save
    blog_size_after_save = Post.all.size
    expect(blog_size_before_save+1).to eq(blog_size_after_save)
  end
end