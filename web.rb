require 'sinatra'
require 'haml'
require './dijkstras'

get '/' do
  haml :index
end

post '/create' do
  @vertices = params[:vertices]
  haml :create
end

post '/result' do
  graph = Graph.new
  params[:vertex].each do |vkey, vvalue|
    if vvalue.length > 0
      neighbours = {}
      params[:neighbour][vkey].each do |nkey, nvalue|
        value = params[:value][vkey][nkey].to_i
        neighbours[nvalue] = value if value > 0
      end
      graph.add_vertex vvalue, neighbours
    end
  end

  @result = graph.shortest_path params[:from], params[:to]

  haml :result
end

__END__

@@ layout
%html
  = yield

@@ index
%form{ :action => "/create", :method => "post"}
  %fieldset
    %ol
      %li
        %label{:for => "vertices"} Vertices Number:
        %input{:type => "text", :name => "vertices", :class => "text"}
  %input{:type => "submit", :value => "Send", :class => "button"}

@@ create
%form{ :action => "/result", :method => "post"}
  %fieldset
    %ol
      - @vertices.to_i.times do |v|
        %li
          %label{:for => "vertex[]"} Vertex name:
          %input{:type => "text", :name => "vertex[#{v}]", :class => "text"}
          %label{:for => "neighbour[][]"} Neighbours:
          - (@vertices.to_i-1).times do |n|
            %input{:type => "text", :name => "neighbour[#{v}][#{n}]", :placeholder => "Node", :style => 'width: 50px;'}:
            %input{:type => "text", :name => "value[#{v}][#{n}]", :placeholder => "Value", :style => 'width: 50px;'}
            %span
              &nbsp;
      %li
        %label{:for => "from"} From:
        %input{:type => "text", :name => "from", :class => "text"}
        %label{:for => "to"} To:
        %input{:type => "text", :name => "to", :class => "text"}
  %input{:type => "submit", :value => "Send", :class => "button"}

@@ result
%p
  The shortest path is:
  - @result.each do |n|
    #{n}
%p
  %a{:href => '/'} back to home
