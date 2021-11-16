class PostsController < SessionsController
  before_action :check_current_user

  def index
    @posts = Post.all
    @tags = Tag.all
  end
  
  def new
    @post = Post.new
  end
  
  def create

    tag_name_list = Array[post_info[:tag1], post_info[:tag2], post_info[:tag3]]
    puts tag_name_list
    puts 'HI!!!!!!!'

    tag_name_list.each do |tag_name|

      if tag_name == ""
        tag_name = "other"
      end
      puts tag_name
      tmp_tag = Tag.find_by(name: tag_name)
      if tmp_tag == nil
        tmp_tag = Tag.create(name: tag_name, freq: 0)
      end
    
    end
    
    puts "ye!!!!!!"
    puts Tag.find_by(name: "other")

    # tmp_tag = Tag.find_by(name: post_info[:tag1])

    # if tmp_tag == nil
    #   tmp_tag = Tag.create(name: post_info[:tag1], freq: 0)
    # else
    #   # tmp_tag.freq = tmp_tag.freq + 1
    #   puts 'HI!!!!!!'

    #   puts tmp_tag.name
    #   # tmp_tag.update(freq: tmp_tag.freq + 1)
    #   puts tmp_tag.freq

    #   # tmp_tag.save
    # end
     
    post = @current_user.posts.create(post_info)
    if post
      # post.update(tag1: tmp_tag.name)
      post.update(tag1: tag_name_list[0],tag2: tag_name_list[1],tag3: tag_name_list[2])
      post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(post_info)
    redirect_to posts_path
  end
  
  private
  
  def post_info
    params.require(:post).permit(:title, :content, :tag1, :tag2, :tag3)
  end

end
