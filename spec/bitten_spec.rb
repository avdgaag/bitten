describe Bitten do

  before do
    Post.has_bits :published, :featured, :sponsored
  end

  subject(:post) { Post.new }

  it { should_not be_published }
  it { should_not be_featured }
  it { should_not be_sponsored }
  it { should respond_to(:published=) }
  it { should respond_to(:featured=) }
  it { should respond_to(:sponsored=) }

  its(:class) { should respond_to(:published) }
  its(:class) { should respond_to(:featured) }
  its(:class) { should respond_to(:sponsored) }
  its(:class) { should respond_to(:not_published) }
  its(:class) { should respond_to(:not_featured) }
  its(:class) { should respond_to(:not_sponsored) }

  it 'can toggle a flag' do
    subject.published = true
    expect(post).to be_published
    subject.published = false
    expect(post).not_to be_published
  end

  describe 'scopes' do
    let!(:post1) { Post.create! published: true }
    let!(:post2) { Post.create! featured: true }

    it 'finds a record by flag' do
      expect(Post.published).to include(post1)
      expect(Post.published).not_to include(post2)
      expect(Post.featured).not_to include(post1)
      expect(Post.featured).to include(post2)
      expect(Post.sponsored).not_to include(post1)
      expect(Post.sponsored).not_to include(post2)
    end

    it 'finds a record by not having a flag' do
      expect(Post.not_published).not_to include(post1)
      expect(Post.not_published).to include(post2)
      expect(Post.not_featured).to include(post1)
      expect(Post.not_featured).not_to include(post2)
      expect(Post.not_sponsored).to include(post1)
      expect(Post.not_sponsored).to include(post2)
    end
  end
end
