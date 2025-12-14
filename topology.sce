clear;
clc;

NameOfNetwork = 'Hybrid_Event_Management_Topology';
NumberOfNodes = 32;
StarStarts = [
  1 1 1 1 1 1 ...
  2 2 2 2 2 2
];
StarEnds = [
  3 4 5 6 7 8 ...
  3 4 5 6 7 8
];
FacultyStarts = [1];
FacultyEnds   = [2];
RingStarts = [3 4 5 6 7 8  4 5 6 7 8 3];
RingEnds   = [4 5 6 7 8 3  3 4 5 6 7 8];
BusStarts = [
  3 9 10 11 12 13 ...
  5 15 16 17 18 19 ...
  6 21 22 23 24 25 ...
  8 27 28 29 30 31
];
BusEnds = [
  9 10 11 12 13 14 ...
  15 16 17 18 19 20 ...
  21 22 23 24 25 26 ...
  27 28 29 30 31 32
];
StartNodesOfEdge = [StarStarts FacultyStarts RingStarts BusStarts];
EndNodesOfEdge   = [StarEnds   FacultyEnds   RingEnds   BusEnds];
XCoordinatesOfNodes = [
  300 600 ...
  100 200 300 400 500 700 ...
  100 100 100 100 100 100 ...
  300 300 300 300 300 300 ...
  400 400 400 400 400 400 ...
  700 700 700 700 700 700
];
YCoordinatesOfNodes = [
  900 900 ...
  800 600 800 800 600 700 ...
  600 500 400 300 200 100 ...
  600 500 400 300 200 100 ...
  600 500 400 300 200 100 ...
  600 500 400 300 200 100
];
TopologyGraph = NL_G_MakeGraph( ...
    NameOfNetwork, NumberOfNodes, ...
    StartNodesOfEdge, EndNodesOfEdge, ...
    XCoordinatesOfNodes, YCoordinatesOfNodes);
NL_G_ShowGraph(TopologyGraph, 1);
xtitle("Window 1: Hybrid Topology","X-Nodes","Y-Nodes");
RingNodes = [3 4 5 6 7 8];
NodeColor = 5;
BorderThickness = 10;
NodeDiameter = 25;
[GraphHighlight, NodeVector] = NL_G_HighlightNodes( ...
    TopologyGraph, RingNodes, ...
    NodeColor, BorderThickness, NodeDiameter, 2);
xtitle("Window 2: Ring Nodes Highlighted","X-Nodes","Y-Nodes");
BusEdges = 26:49;
EdgeColor = 3;
EdgeWidth = 8;
[GraphHighlightEdges, EdgeVector] = NL_G_HighlightEdges( ...
    GraphHighlight, BusEdges, ...
    EdgeColor, EdgeWidth, 3);
xtitle("Window 3: Bus Edges Highlighted","X-Nodes","Y-Nodes");
NL_G_ShowGraphNE(TopologyGraph, 4);
xtitle("Window 4: Node and Edge Numbering","X-Nodes","Y-Nodes");

disp("a. Created topology is displayed");
disp("b. Nodes and edges are numbered");
disp("c. Ring nodes and bus edges are coloured");
[e_head, e_tail, e_color, e_width, e_length, e_weight, e_number] = ...
    NL_G_EdgeDataFields(TopologyGraph);
NodeDegree = zeros(1, NumberOfNodes);
for i = 1:length(e_head)
    NodeDegree(e_head(i)) = NodeDegree(e_head(i)) + 1;
    NodeDegree(e_tail(i)) = NodeDegree(e_tail(i)) + 1;
end
disp("d. Number of edges connected to each node:");
for i = 1:NumberOfNodes
    disp("Node " + string(i) + " : " + string(NodeDegree(i)));
end
[maxEdges, maxNode] = max(NodeDegree);
disp("Node with maximum edges: " + string(maxNode));
disp("Maximum number of edges: " + string(maxEdges));
[nodes, edges] = NL_G_GraphSize(TopologyGraph);
disp("e. Total number of nodes: " + string(nodes));
disp("Total number of edges: " + string(edges));
