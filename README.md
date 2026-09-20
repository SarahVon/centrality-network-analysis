# Centrality & Network Analysis

I analyze a directed teacher friendship network, moving from graph construction and cohesion measures to node-level centrality and visual comparison.

## Purpose

This analysis examines how cohesive the supplied directed network is, which actors receive the most reported ties, and which occupy brokerage positions. In-degree and betweenness highlight different forms of prominence.

## Data and authorization

The adjacency CSV records directed reported friendships; the attributes CSV contains pseudonymous IDs, coded demographics and position fields, tenure fields, and numeric survey measures. Publication of these supplied CSVs was authorized by the project owner. Do not attempt re-identification or redistribute them beyond that authorization boundary.

## Workflow and measures

`centrality-analysis.R` reads the project-relative CSVs and creates a directed `igraph` graph. I calculate weak components, density, compactness, reciprocity, global clustering/transitivity, in-degree, and normalized betweenness. A fixed seed supports paired plots with node size scaled by each centrality measure.

![Centrality network analysis](centrality-network-analysis.png)

*Network views comparing in-degree and betweenness centrality.*

See the [centrality graphs PDF](centrality-graphs.pdf) for accompanying figures.

## Findings

The supplied analysis reports **8 weak components**, density **0.042**, compactness **0.181**, reciprocity **0.393**, and global clustering coefficient **0.200**. AE and AX ranked highest by in-degree; AE and AL ranked highest by betweenness. In-degree is the more direct popularity proxy here, while betweenness highlights brokerage.

## Limitations

The network records reported friendship ties, not every relationship. It represents one school context, and coded attributes lack a complete codebook. Results depend on graph construction and measure choices and should not be generalized. Published visuals omit labels to protect the pseudonymous context.

## Reproducibility

Install R and `igraph`, then run `centrality-analysis.R` from the project directory. The script expects the two CSV files alongside it and reproduces the graph construction, metrics, rankings, and plot logic.

## Repository contents

- `centrality-analysis.R`
- `teacher-friendship-adjacency.csv`
- `teacher-network-attributes.csv`
- `centrality-network-analysis.png`
- `centrality-graphs.pdf`
- `report-summary.md`
