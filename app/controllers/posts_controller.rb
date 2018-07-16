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
  def categories_attributes=(category_attributes)
    category_attributes.value.each do |attribute|
      category=Category.find_or_create_by(attribute)
      self.categories<<category
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, category_ids:[], categories_attributes: [:name])
  end
end
