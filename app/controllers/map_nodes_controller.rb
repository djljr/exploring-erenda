class MapNodesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @map_node_pages, @map_nodes = paginate :map_nodes, :per_page => 10
  end

  def show
    @map_node = MapNode.find(params[:id])
    @nodes = MapNode.find_all
  end

  def new
    @map_node = MapNode.new
    @nodes = MapNode.find_all
  end

  def create
    @map_node = MapNode.new(params[:map_node])
    @map_node.source_paths = MapNode.find(params[:node_ids]) if params[:node_ids]
    if @map_node.save
      flash[:notice] = 'MapNode was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @map_node = MapNode.find(params[:id])
    @nodes = MapNode.find_all
  end

  def update
    @map_node = MapNode.find(params[:id])
    if params[:node_ids]
      @map_node.source_paths = MapNode.find(params[:node_ids])
    else
      @map_node.source_paths = {}
    end 
    if @map_node.update_attributes(params[:map_node])
      flash[:notice] = 'MapNode was successfully updated.'
      redirect_to :action => 'show', :id => @map_node
    else
      render :action => 'edit'
    end
  end

  def destroy
    MapNode.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def graph
    @nodes = MapNode.find_all
    @dot = 'digraph Map {'
    for node in @nodes
      for nnode in node.source_paths
        @dot = @dot + '"' + node.name + '" -> "' + nnode.name + '"'
      end  
    end    
    @dot = @dot + '}'
    if RAILS_ENV == 'production'
      f = IO.popen("~/bin/dot -q -Tsvg", "w+")
    else
      f = IO.popen("c:/program files/att/graphviz/bin/dot.exe -q -Tsvg", "w+")
    end
    f.puts(@dot) 
    f.close_write
    @img = f.read
    #parse_svg=REXML::Document.new(@img)
    #@svg_width=parse_svg.root.attributes["width"].gsub(/pt$/,'').to_i
    #@svg_height=parse_svg.root.attributes["height"].gsub(/pt$/,'').to_i    
    f.close
    @headers["Content-Type"] = "image/svg+xml"
    render :text => @img
  end
end
