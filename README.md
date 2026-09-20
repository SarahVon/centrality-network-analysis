# Centrality & Network Analysis

An exploratory network-analysis project using a directed teacher friendship network. The workflow moves from graph construction and cohesion measures to node-level centrality measures and visual comparison.

## Analysis sequence

1. **Construct the network.** `centrality-analysis.R` reads the directed adjacency matrix and node attributes and creates an `igraph` graph.
2. **Describe cohesion.** The analysis calculates weak components, density, compactness, dyadic reciprocity, and global clustering (transitivity).
3. **Compare centrality.** It calculates in-degree and normalized betweenness, then identifies the most prominent actors under each measure.
4. **Visualize the contrast.** The published plots use a fixed layout seed and size nodes by in-degree or betweenness, making the different interpretations of prominence visible.

Reported results include 8 weak components, density 0.042, compactness 0.181, reciprocity 0.393, and global clustering coefficient 0.200. AE and AX were highest by in-degree; AE and AL were highest by betweenness.

## Files

- `centrality-analysis.R` — reproducible analysis script with project-relative inputs.
- `teacher-friendship-adjacency.csv` — directed adjacency matrix; a 1 in row *i*, column *j* represents a reported friendship from *i* to *j*.
- `teacher-network-attributes.csv` — node-level attributes. `ID` is the node identifier; `Gender`, `Gradelevel`, and `Position` are coded categorical fields; `YrsCurPos` and `YrsCurSite` are tenure-in-years fields; `OverallTrust` and `DistClimateLrn` are numeric survey measures.
- `centrality-network-analysis.png`, `centrality-graphs.pdf` — network visual outputs.
- `report-summary.md` — sanitized report summary.

## Visualizations

![Centrality network analysis](centrality-network-analysis.png)

*Network views comparing in-degree and betweenness centrality.*

See the [centrality graphs PDF](centrality-graphs.pdf) for the accompanying graph figures.

## Data sources and permissions

The CSVs are the original teacher friendship and attribute files supplied for the analysis. Publication was explicitly authorized by the project owner. Node IDs are pseudonymous codes; no names or direct contact details are included. Do not attempt to re-identify individuals, and verify institutional or participant permissions before redistribution beyond this portfolio context. Codebook details for the coded fields are not included in the source materials.

## Limitations

The network records reported friendship ties, not all social or professional relationships. Directed ties may be unreciprocated, the sample is limited to one school context, and coded attributes lack a complete codebook. Measures depend on graph construction choices and should not be generalized to other populations.

## Reproducibility

Run the R script from this repository directory with R and the `igraph` package installed. It expects the two CSV files at the repository root and writes/plots results in the active R session. The supplied script preserves the analysis logic while removing machine-specific paths.
