# Teacher Friendship Network Cohesion and Centrality Analysis

An `R` and `igraph` analysis of a directed, pseudonymized teacher friendship network. The project evaluates the network's overall cohesion and compares two forms of node-level prominence: the number of friendship nominations an actor receives and the extent to which an actor connects otherwise separate parts of the network.

## Project purpose

I completed this project to practice applying social network analysis methods to a real directed network. The analysis addresses two related questions:

- How cohesive is the network as a whole?
- Which actors appear most central, and does the answer change depending on how centrality is defined?

The project moves from graph construction and network-level measures to actor-level centrality rankings and a side-by-side visual comparison.

## Tools and methods

- **`R`** for data preparation, analysis, and visualization
- **`igraph`** for graph construction, cohesion measures, and centrality calculations
- **Base R graphics** for the paired network plots

The workflow:

1. Imports the directed friendship adjacency matrix and the accompanying node-attribute table.
2. Constructs a directed `igraph` network in which a tie from actor *i* to actor *j* indicates that *i* reported a friendship with *j*.
3. Measures network cohesion using weak components, density, compactness, dyadic reciprocity, and global transitivity.
4. Calculates in-degree and normalized betweenness centrality for each actor.
5. Ranks actors by each centrality measure.
6. Uses a fixed layout seed to create comparable network views, with node size representing the selected centrality measure.

## Data

The analysis uses a pseudonymized network of **31 actors** and **39 directed friendship ties**.

| File | Description |
| --- | --- |
| [`teacher-friendship-adjacency.csv`](teacher-friendship-adjacency.csv) | A 31 × 31 directed adjacency matrix. Rows represent the actor reporting a friendship, columns represent the nominated actor, and a value of `1` indicates a reported tie. |
| [`teacher-network-attributes.csv`](teacher-network-attributes.csv) | One record per actor with a pseudonymous ID and coded fields for gender, grade level, position, years in the current position, years at the current site, overall trust, and district climate for learning. |

The attribute file is retained as supporting context but is not used in the reported cohesion or centrality calculations. Publication of the supplied pseudonymized files was authorized for this project. Because social-network data can remain sensitive even when direct identifiers are removed, the files should not be used to infer or reconstruct participant identities.

## Results

### Network cohesion

| Measure | Result | Interpretation |
| --- | ---: | --- |
| Weak components | **8** | The network is divided into multiple disconnected groups, including actors who cannot be reached from the main component when tie direction is ignored. |
| Density | **0.042** | Approximately 4.2% of all possible directed ties are present, indicating a sparse network. |
| Compactness | **0.181** | The mean reciprocal directed path length is low, reflecting limited reachability and relatively long paths across the full network. |
| Dyadic reciprocity | **0.393** | A portion of reported ties are mutual, but most connected pairs are not reciprocal under `igraph`'s ratio definition. |
| Global transitivity | **0.200** | Some local clustering is present, although closed triads are not common across the network. |

Taken together, the measures describe a sparse and fragmented network rather than one cohesive group. Friendship ties form several smaller structures, and connections between those structures are limited. These results describe the observed reporting pattern only; they do not establish the quality of workplace relationships or the level of professional collaboration.

### Centrality

| Measure | Highest-ranked actors | What the measure represents |
| --- | --- | --- |
| In-degree | **AE and AX** | The number of friendship nominations an actor receives; in this context, it is the more direct indicator of reported popularity. |
| Betweenness | **AE and AL** | The frequency with which an actor falls along shortest directed paths between other actors; it highlights potential brokerage or bridging positions. |

AE ranks highly under both measures, suggesting prominence through both incoming friendship ties and network position. The second-ranked actor changes from AX for in-degree to AL for betweenness, demonstrating that being frequently nominated and serving as a structural bridge are related but distinct forms of centrality.

## Visualization

![Side-by-side teacher friendship networks scaled by in-degree and betweenness centrality](centrality-network-analysis.png)

*The same directed network is shown in both panels. Larger nodes have higher in-degree in the left panel and higher betweenness in the right panel. Labels are omitted from the public figure to reduce unnecessary exposure of pseudonymous actor IDs.*

The [`centrality-graphs.pdf`](centrality-graphs.pdf) file provides a PDF version of the paired visualization.

## Interpretation notes and limitations

- A reported friendship tie is a self-reported relationship, not a complete measure of interaction, influence, or collaboration.
- The analysis represents one school network at one point in time and should not be generalized to other settings.
- Weak components describe connectivity after ignoring tie direction, while the compactness and betweenness calculations use directed paths.
- The compactness value is calculated as the mean reciprocal geodesic distance, with unreachable actor pairs contributing zero and self-distances excluded.
- `igraph`'s global transitivity calculation does not preserve the direction of ties when evaluating closed triples.
- Centrality identifies structural position, not causation, personal importance, or job performance.
- The coded attribute fields do not include a complete public codebook and are not interpreted in this analysis.
- Network layouts support visual comparison but should not be read as geographic positions or exact social distance.

## Reproducing the analysis

Install `R` and `igraph`, then run the analysis from the repository directory:

```r
install.packages("igraph")
source("centrality-analysis.R")
```

The script requires the two CSV files listed above. Before running it, confirm that its input filenames match the repository filenames and remove or update any machine-specific working-directory path. The fixed random seed preserves the paired plot layout, although small visual differences may occur across `R` or `igraph` versions.

## Repository contents

| File | Description |
| --- | --- |
| [`centrality-analysis.R`](centrality-analysis.R) | R source code for graph construction, cohesion measures, centrality rankings, and visualization |
| [`teacher-friendship-adjacency.csv`](teacher-friendship-adjacency.csv) | Directed friendship adjacency matrix |
| [`teacher-network-attributes.csv`](teacher-network-attributes.csv) | Pseudonymized node attributes |
| [`centrality-network-analysis.png`](centrality-network-analysis.png) | Side-by-side in-degree and betweenness network visualization |
| [`centrality-graphs.pdf`](centrality-graphs.pdf) | PDF version of the paired network plots |
| [`report-summary.md`](report-summary.md) | Additional interpretation and project notes |
| `README.md` | Project overview, methods, findings, and reproducibility notes |
