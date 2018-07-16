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
  def categories_attributes=(category_hashes)
    #hash looks like this {"0"={name:"New Category"}, "1"={name:"Other New Category"}}
    #for every value in the categoery_attributes hash...
    category_hashes.value.each do |i,category_attr|
      #each will be this: {name:"New Category"} - a hash that can be used to create a new cateogry
      #find or create a category by that attribute (will pass key and value in?)
      category=Category.find_or_create_by(name: category_attr[:name]))

      #make a new post_category instance using the category
      #will make a new post_category with post_id of self.id and category_id of category.id
      self.post_categories.build(category:category)
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
