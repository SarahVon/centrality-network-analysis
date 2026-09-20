# Centrality & Network Analysis

I analyze a directed teacher friendship network, moving from graph construction and cohesion measures to node-level centrality measures and visual comparison.

## Contents

- [Purpose and questions](#purpose-and-questions)
- [Data fields and authorization](#data-fields-and-authorization)
- [Graph construction and measures](#graph-construction-and-measures)
- [Visual sequence](#visual-sequence)
- [Findings](#findings)
- [Limitations](#limitations)
- [Reproducibility](#reproducibility)
- [Repository contents](#repository-contents)

## Purpose and questions

The analysis asks how cohesive the supplied directed friendship network is, which actors receive the most reported ties, and which actors occupy brokerage positions. It also asks why in-degree and betweenness can identify different kinds of prominence.

## Data fields and authorization

The adjacency CSV records directed reported friendships: a `1` in row *i*, column *j* represents a reported tie from *i* to *j*. The attributes CSV includes pseudonymous `ID`, coded `Gender`, `Gradelevel`, and `Position`, tenure fields `YrsCurPos` and `YrsCurSite`, and numeric survey measures `OverallTrust` and `DistClimateLrn`. Publication of these supplied CSVs was explicitly authorized by the project owner. Node IDs are pseudonymous; do not attempt re-identification or redistribute beyond the authorization boundary. No DOCX source is included, and the coded-field codebook is not available here.

## Graph construction and measures

`centrality-analysis.R` reads the two project-relative CSVs and creates a directed `igraph` graph from the adjacency matrix. I calculate:

- weak components, density, compactness, dyadic reciprocity, and global clustering/transitivity;
- in-degree as a direct count of incoming reported ties; and
- normalized betweenness as a measure of shortest-path brokerage.

The script uses a fixed seed for the paired plots and scales node size by the measure being shown.

## Visual sequence

1. **Construct:** represent the directed adjacency matrix as a graph.
2. **Describe cohesion:** summarize fragmentation, connection density, reachability, mutuality, and local clustering.
3. **Compare centrality:** rank actors by in-degree and betweenness.
4. **Visualize the contrast:** compare the same network layout with node size weighted by each measure.

![Centrality network analysis](centrality-network-analysis.png)

*Network views comparing in-degree and betweenness centrality.*

See the [centrality graphs PDF](centrality-graphs.pdf) for the accompanying graph figures.

## Findings

The supplied analysis reports **8 weak components**, density **0.042**, compactness **0.181**, reciprocity **0.393**, and global clustering coefficient **0.200**. AE and AX were highest by in-degree; AE and AL were highest by betweenness. In-degree is the more direct proxy for popularity here, while betweenness highlights structural position between other nodes.

## Limitations

The network records reported friendship ties, not every social or professional relationship. Directed ties may be unreciprocated, the sample represents one school context, and coded attributes lack a complete codebook. Results depend on graph construction and measure choices and should not be generalized to other populations. The published visuals omit labels to protect the pseudonymous network context.

## Reproducibility

Install R and `igraph`, then run `centrality-analysis.R` from the project directory. The script expects the two CSV files alongside it and reproduces the graph construction, metrics, rankings, and plot logic using project-relative paths. Exact report prose is not reproduced; `report-summary.md` provides the sanitized results boundary.

## Repository contents

- `centrality-analysis.R` — analysis script
- `teacher-friendship-adjacency.csv` — authorized directed adjacency matrix
- `teacher-network-attributes.csv` — authorized pseudonymous node attributes
- `centrality-network-analysis.png` — paired visual output
- `centrality-graphs.pdf` — accompanying graph figures
- `report-summary.md` — sanitized findings and privacy boundary
