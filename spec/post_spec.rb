require_relative "../models/post.rb"
require "spec_helper"
require 'active_record'


describe Post do
  before :each do
    @post = Post.new('Title', 'Body')
  end

  it 'must have a title and a body' do
    expect{Post.new}.to raise_error(ArgumentError)
  end

  it 'must have a title' do
    expect{Post.new('Body')}.to raise_error(ArgumentError)
  end

  it 'must have a body' do
    expect{Post.new('Title')}.to raise_error(ArgumentError)
  end

  it 'has a valid title and body' do
    expect(@post).to be_valid
  end

  # it 'has a valid body' do
  #   expect(FactoryGirl.build(:post, year: nil)).to_not be_valid
  # end
  # it "should reverse the string you provide it" do
  #   expect('Jeffrey').to eq('Jeffrey')
  # end
end