class PostsController < ApplicationController # rubocop:disable Style/Documentation
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end
  def create
    @post = current_user.posts.build(post_params) # Associa a postagem ao usuário logado
  
    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Postagem criada com Sucesso!" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Postagem atualizada com Sucesso!" }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Postagem apagada com Sucesso." }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
