class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new

  end

  def create
    post = Post.create(post_params)
    redirect_to post
  end

  #custom setter for nested category creation
  #automatically called when line 16 above is called
  def categories_attributes=(category_attributes)
    #for every value in the categoery_attributes hash...
    category_attributes.value.each do |attribute|
      #find or create a category by that attribute (will pass key and value in?)
      category=Category.find_or_create_by(attribute)
      #link it up manually by shoveling it into self cateogires
      self.categories<<category
    end
  end

  def comments_attributes=(attr)
    @comment=Comment.new(attr)
    @comment.post_id=self.id
    self.comments<<@comment
    @comment.save
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, category_ids:[], categories_attributes: [:name], comments_ids:[])
  end
end
