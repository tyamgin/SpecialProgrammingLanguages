var data = document.getElementById('data').innerHTML;
root = JSON.parse(data);
                 

var cluster = d3.layout.cluster()
	.size([height-50, width - 160]);
                 
var diagonal = d3.svg.diagonal()
	.projection(function(d) { return [d.y, d.x]; });

var svg = d3.select('body').append('svg')
	.attr('width', width + 400)
	.attr('height', height)
	.append('g')
	.attr('transform', 'translate(40,0)');


var nodes = cluster.nodes(root),
	links = cluster.links(nodes);

var link = svg.selectAll('.link')
	.data(links)
	.enter().append('path')
	.attr('class', 'link')
	.attr('d', diagonal);

var node = svg.selectAll('.node')
	.data(nodes)
	.enter().append('g')
	.attr('class', 'node')
	.attr('transform', function(d) { return 'translate(' + d.y + ',' + d.x + ')'; })

node.append('circle')
	.attr('r', 4.5);

node.append('text')
	.attr('dx', function(d) { return d.children ? 8 : 8; })
	.attr('dy', function(d) { return d.children ? 20 : 4; })
	.style('text-anchor', function(d) { return d.children ? 'end' : 'start'; })
	.text(function(d) { 
		return d.name.replace('https://ru.wikipedia.org/wiki/', '').split('_').join(' ');
	})
	.on('click', function(d) { window.open(d.name); })
	.attr('leafnode', function(d) { return !d.children; });

d3.select(self.frameElement).style('height', height + 'px');