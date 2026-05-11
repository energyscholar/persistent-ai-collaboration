# Observing the Magnetosphere-Ionosphere Current System from the Ground

*A tutorial covering the physics of ground magnetic perturbations, the spatial-spectral analysis pipeline, and what we've found so far. Broad context first, then drill-down to our specific techniques and data.*

---

## Part 1: The Big Circuit

The magnetosphere-ionosphere (M-I) system is a single electrical circuit. Solar wind kinetic energy drives it; Joule heating in the ionosphere dissipates it. Everything we observe on the ground — magnetic perturbations of hundreds to thousands of nT during storms — is current flowing through this circuit.

The circuit has four segments:

1. **Magnetopause / ring currents** — driven by solar wind compression and particle injection
2. **Field-aligned currents (FACs)** — Birkeland currents flowing along magnetic field lines between magnetosphere and ionosphere
3. **Ionospheric currents** — Hall and Pedersen currents in the conducting E-region (~90–130 km altitude)
4. **Ground induction** — secondary currents in the conducting Earth, opposing the ionospheric currents (Lenz's law)

![M-I Current Circuit](img/03_current_circuit.png)

The key Lenz's law framing: the **solar wind compresses the magnetosphere**, adding magnetic flux to the polar cap. The **M-I current system opposes this** — FACs close through ionospheric currents whose magnetic field opposes the flux addition. The system is always trying to reach equilibrium, never quite getting there. The energy extracted from solar wind convection is dissipated as Joule heating: **P = J · E**, where the Pedersen current (along E) does the heating. The Hall current (perpendicular to E) does no work but creates the largest ground magnetic perturbation.

**Energy budget during storms:** Solar wind input ~10¹² W → ~30% to ring current, ~30% to ionospheric Joule heating, ~10% to auroral particle precipitation, ~30% to tail/other. The ionospheric Joule heating term is what we observe indirectly through ground magnetometers.


## Part 2: Where Hall Currents Form

This was the question that needed a clear picture. Here it is.

![Hall Current Formation](img/01_hall_current_formation.png)

### The E-Region (90–130 km)

The ionospheric E-region is the narrow altitude band where Hall currents exist. The physics:

- **Electrons** are strongly magnetized (gyrofrequency >> collision frequency). They cannot move along the electric field E — instead they **E×B drift**, moving perpendicular to both E and B. This drift is the same physics as the [Hall effect](https://en.wikipedia.org/wiki/Hall_effect) in a conductor.

- **Ions** (mostly O⁺ at these altitudes) are partially magnetized but collision-dominated. They collide with neutrals before completing a gyration, so they drift along E — the **Pedersen drift**.

- **Below ~90 km** (D-region): both species are collision-dominated. No differential drift, no current.

- **Above ~130 km** (F-region): both species are magnetized. Both E×B drift together. No differential drift, no current.

The Hall current is the **electron E×B drift minus the ion drift**:

    J_H = σ_H (B̂ × E)

where σ_H is the [Hall conductivity](https://en.wikipedia.org/wiki/Hall_effect#Hall_conductivity), which depends on electron density (ionization from solar UV and particle precipitation).

### The Electrojet IS the Hall Current

The auroral electrojet — the intense east-west current in the auroral zone — is simply the Hall current in the E-region. When you see "electrojet" in the literature, think "Hall current integrated over the E-region altitude." The electrojet is east-west because:

- B is approximately vertical at auroral latitudes (~70° MLAT)
- E is approximately equatorward (from magnetospheric convection mapped along field lines)
- J_H = σ_H(B̂ × E) points east-west

### Pedersen Current Closes the Circuit

The Pedersen current flows along E (equatorward), connecting the upward and downward FAC sheets. This is where Joule heating happens: **P = σ_P |E|²**. The Pedersen current does work; the Hall current doesn't (J_H ⊥ E, so J_H · E = 0).

### Seasonal Dependence

In **winter darkness**, solar UV doesn't ionize the E-region. Conductivity drops. The ionosphere becomes resistive. FACs can't close efficiently through Hall/Pedersen currents, so the **ground magnetic perturbation becomes dominated by the FAC pattern directly** rather than by the Hall current pattern ([Laundal et al. 2015, GRL](https://doi.org/10.1002/2014GL062816)). This is key for interpreting our spatial statistics — the spatial structure we measure changes with season even if the driving current system doesn't.

In **summer**, strong UV ionization → high Hall conductivity → ground signal dominated by the electrojet. More spatially variable, masks FAC structure.


## Part 3: The Polar View — R1, R2, and the 12-Hour Switch

![Polar Current System](img/02_polar_current_system.png)

### Region 1 and Region 2 FACs

The FAC system organizes into two concentric rings around the magnetic pole:

- **Region 1 (R1):** Poleward ring, ~68–75° MLAT. Connects to the magnetopause current. R1 is the primary driver — it carries the energy extracted from solar wind reconnection.

- **Region 2 (R2):** Equatorward ring, ~58–68° MLAT. Connects to the [ring current](https://en.wikipedia.org/wiki/Ring_current). R2 is the return path — it closes the ionospheric Pedersen current circuit.

The R1/R2 system is "almost permanent" — it's always there, scaling up and down with solar wind energy input. The correlation between AE index (a measure of electrojet strength) and total FAC is r = 0.90–0.93 ([Pedersen et al. 2021](https://doi.org/10.1029/2020JA028628)). They measure the same system.

### The 12-Hour Switch

This is one of the most striking features of the M-I system. **R1/R2 polarity reverses from dawn to dusk:**

| | Dusk (18 MLT) | Dawn (06 MLT) |
|---|---|---|
| **R1** | Upward (out of ionosphere) | Downward (into ionosphere) |
| **R2** | Downward | Upward |

Why? The magnetospheric convection electric field E points from dawn to dusk across the polar cap (driven by the reconnection geometry). Since the Pedersen current flows along E (dusk-to-dawn), it must be fed by downward FAC on dawn and drained by upward FAC on dusk — which is exactly the R1 pattern. R2 closes the circuit with opposite polarity.

The reversal at the dawn-dusk meridian creates the **Harang discontinuity** (~21 MLT) where the eastward and westward electrojets meet. The Harang is not a simple boundary — it shifts with activity level and has complex internal structure.

### What Ground Magnetometers See

A station at ~70° MLAT under the electrojet sees:
- **X (north) component:** dominated by the east-west electrojet (Hall current). Negative perturbation (southward) during substorms when the westward electrojet intensifies.
- **Y (east) component:** sensitive to FAC polarity reversals and the Harang discontinuity.
- **Z (vertical) component:** **direct FAC proxy** ([Weimer 2010](https://doi.org/10.1029/2010JA015544)). Overhead FAC density maps to Z perturbation. This is why Z carries more spatial information than H in 71% of months (our S60 finding).


## Part 4: The Plasma Sheet

![Plasma Sheet Ion Dynamics](img/06_plasma_sheet.gif)

### Ion Cyclotron Motion in the Tail

The [plasma sheet](https://en.wikipedia.org/wiki/Plasma_sheet) is the hot (keV), dense plasma layer in the magnetic equatorial plane of the magnetotail, extending from ~6 to >30 R_E tailward. The magnetic field here is weak (~5 nT, vs. ~50,000 nT at the surface).

In this weak field, ion [gyroradii](https://en.wikipedia.org/wiki/Gyroradius) become enormous:

    r_g = mv⊥ / (qB) ≈ 500–1000 km for 5 keV protons in 5 nT

This is NOT small compared to the current sheet thickness (~1–2 R_E). Ions are **not well magnetized** — they don't simply follow field lines. They execute complex [Speiser orbits](https://doi.org/10.1029/JZ071i013p03369): bouncing across the current sheet, gaining energy from the dawn-dusk electric field with each crossing. This creates a cross-tail current — the [tail current sheet](https://en.wikipedia.org/wiki/Magnetotail#Magnetotail_current_sheet).

### Substorm Disruption

During substorm onset, the near-tail current sheet (~8–12 R_E) thins until ion orbits become chaotic. The ordered cyclotron motion breaks down:

1. **Growth phase:** Solar wind energy loads the tail. Current sheet thins. B_z component weakens.
2. **Onset:** Current disruption — the orderly Speiser orbits become chaotic. Magnetic reconnection may trigger or follow (causality debated for 50 years).
3. **Expansion:** The disrupted current diverts along field lines as the [substorm current wedge](https://en.wikipedia.org/wiki/Substorm#Substorm_current_wedge) (SCW). This is a localized R1-like FAC that creates the sudden intensification seen by ground magnetometers.
4. **Recovery:** Tail rebuilds. Current sheet re-forms. Ordered cyclotron motion resumes.

The SCW is what creates the sharp, localized substorm signatures that our temporal analysis detects — pattern persistence drops to 2–3 minutes at storm peak because the current system is being constantly disrupted and reformed.


## Part 5: What We Can Observe

![Observation Scales](img/04_observation_scales.png)

### The Instrument Hierarchy

Different instruments see different spatial and temporal scales:

| Instrument | Spatial Scale | Temporal | What It Sees |
|---|---|---|---|
| **SuperMAG** (~100 stations, global) | 500–10,000 km | 1 min | Large-scale electrojet, ring current, SYM-H |
| **IMAGE** (~30 stations, Scandinavia) | 88–2,355 km | 1 min (10 sec available) | Regional FAC structure, electrojet fine structure |
| **Cluster** (4 spacecraft, in-situ) | 10–1,000 km | sub-second | Current sheet crossings, wave measurements |
| **MMS** (4 spacecraft, in-situ) | 10–100 km | millisecond | Electron-scale physics, reconnection geometry |

Ground magnetometers integrate the magnetic field of ALL currents above them — FACs, Hall, Pedersen, ring current — weighted by ~1/r². The "footprint" for a current at 110 km altitude is roughly ±100 km. This sets the minimum resolvable scale for ground observations.

### IMAGE Network Specifics

The IMAGE ([International Monitor for Auroral Geomagnetic Effects](https://space.fmi.fi/image/)) network spans Fennoscandia from Svalbard (~79°N) to central Europe (~52°N). For our Halloween 2003 analysis:

- **26 stations** reporting (of ~37 in the full network)
- **325 unique station pairs** for spatial statistics
- **Minimum spacing:** 88 km (e.g., TRO-KIL)
- **Maximum extent:** 2,355 km (NAL-BRZ)
- Dense cluster in the auroral zone (65–70°N): ideal for R1/R2 boundary work
- 104 pairs below 500 km → good short-range variogram coverage

![IMAGE Network](img/09_image_network.png)

### What 1-Minute Data Resolves

With 1-minute sampling at IMAGE:
- **Convection band (>10 min period):** Fully resolved. L ~ 2,000–5,000 km. Electrojet sheets.
- **Pc5 ULF band (3–10 min period):** Resolved but near transition. L ~ 500–3,000 km. Field line resonances.
- **Pi2 band (40–150 s period):** Barely resolved. L ~ 200–1,000 km. Substorm onset. **Nyquist limit at 2 min** — need 10-sec data to confirm.
- **Pc3 band (10–40 s):** NOT resolved. Need 10-sec or faster data.


## Part 6: Our Analysis Pipeline

We combine three independent analysis axes — spatial, temporal, spectral — to characterize the M-I current system from ground magnetometer data. The pipeline is implemented in `scripts/spectral_spatial.py`.

### Axis 1: Spatial Autocorrelation

**[Moran's I](https://en.wikipedia.org/wiki/Moran%27s_I):** A single number measuring global spatial autocorrelation, from -1 (perfect dispersion) through 0 (random) to +1 (perfect clustering). We compute it at each timestep using inverse-distance weighting:

    I = (N/W) × Σᵢ Σⱼ wᵢⱼ(xᵢ - x̄)(xⱼ - x̄) / Σᵢ(xᵢ - x̄)²

where wᵢⱼ = 1/dᵢⱼ and W = Σwᵢⱼ.

For Halloween 2003: **I = +0.248** (median over storm period). Strongly positive — the perturbation field is spatially organized, not random. This is the electrojet's signature.

**[LISA](https://en.wikipedia.org/wiki/Indicators_of_spatial_association) (Local Moran's I):** Decomposition into per-station contributions. Shows WHERE the spatial structure is. At storm peak: High-High clusters in Svalbard (polar cap), Low-Low in the electrojet zone, High-Low at the equatorward boundary. Clean latitude gradient — no anomalous longitudinal structure.

### Axis 2: Geostatistical Structure

**[Variogram](https://en.wikipedia.org/wiki/Variogram):** Semivariance γ(h) as a function of station separation h. Increases from nugget (measurement noise) to sill (total variance) over the **correlation length** L — the distance at which perturbations become uncorrelated.

We fit three [Matérn](https://en.wikipedia.org/wiki/Mat%C3%A9rn_covariance_function) models:
- **ν = 1/2** (exponential): Rough fields. The simplest model.
- **ν = 3/2:** Once-differentiable. Physically correct for current sheets (kinks, not discontinuities).
- **ν = 5/2:** Twice-differentiable. Smooth fields.

**ν = 3/2 wins** at storm peak by AIC. The exponential (ν = 1/2) fails catastrophically (R² = -1.0). This matters: the practical range depends on ν. For ν = 3/2, practical range = 4.90 × scale parameter ℓ, vs. 2.83 × ℓ for exponential. **Our reported correlation lengths are model-dependent** — always report both ℓ and effective range.

**Directional variograms** reveal anisotropy: split pairs into N-S and E-W sectors, fit independently. The electrojet creates a ~10:1 E-W:N-S anisotropy ratio at storm peak.

### Axis 3: Spectral Correlation Length L(f)

This is the key deliverable. For each frequency f:

1. Compute the N×N [cross-spectral density matrix](https://en.wikipedia.org/wiki/Spectral_density#Cross-spectral_density) Sᵢⱼ(f) using [multi-taper estimation](https://en.wikipedia.org/wiki/Multitaper) (Thomson 1982, NW=4, K=7 DPSS tapers)
2. Extract coherence: γ²ᵢⱼ(f) = |Sᵢⱼ(f)|² / [Sᵢᵢ(f) · Sⱼⱼ(f)]
3. Fit spatial decay: γ²(f, d) = exp(-d / L(f))

**L(f) tells us how spatial scale depends on frequency.** Different predictions:
- L(f) constant → broadband FAC (all frequencies have same spatial scale)
- L(f) power-law → turbulent cascade
- L(f) peaked → resonant modes at specific frequencies

### Phase Structure

From the cross-spectral matrix, extract phase φᵢⱼ(f) = arg(Sᵢⱼ(f)):
- **Random phases** (high circular variance) → incoherent noise
- **Linear phase gradient** φᵢⱼ = k·Δr → traveling wave
- **Clustered at 0 or π** → standing wave

Phase structure discriminates between traveling ULF waves and standing [field line resonances](https://en.wikipedia.org/wiki/Field_line_resonance) (FLRs).


## Part 7: What We Found

### L(f) Is NOT Flat

![L(f) Interpretation](img/05_lf_interpretation.png)

The spectral correlation length **increases with period**: ~700 km at 3 min to ~2,000 km at 30 min (X component, storm peak). This rules out the simplest broadband FAC interpretation.

Physical picture: **short-period perturbations are spatially localized** (FAC filaments, FLR nodes) while **long-period perturbations are spatially extended** (large-scale convection, electrojet sheets). The current system has different spatial scales at different frequencies — it's not a single structure observed at multiple frequencies but multiple structures each with their own characteristic scale.

Comparison: [Käki et al. (2026)](https://doi.org/10.1029/2025JA034567) found ℓ ≈ 600 km using Bayesian SECS with a Matérn prior — but their ℓ is a Matérn scale parameter, not our coherence decay length. With ν = 3/2, their effective range ≈ 2,940 km, consistent with our broadband estimate.

### Frequency-Dependent Anisotropy Reversal

![Anisotropy Reversal](img/07_anisotropy_reversal.png)

**This appears to be unreported in the literature.** The dominant spatial orientation of perturbations reverses with frequency:

- **Low frequency (>10 min period):** L_EW/L_NS = 4–11×. Perturbations are extended east-west. The electrojet (a sheet current) dominates.
- **Crossover at ~7–15 min** (shorter for stronger storms): ~2.2 mHz, coincident with FLR eigenfrequency at L ≈ 6.
- **High frequency (<5 min period):** L_EW/L_NS = 0.1–0.5. Perturbations are extended north-south. FAC filaments (N-S aligned) and/or Alfvén waves dominate.

**Replicated in 2 events** (Halloween 2003 and St. Patrick's 2015, X component).

The Z component shows the **opposite** pattern: L_NS > L_EW at low frequency. This is consistent with Z being a FAC proxy while X is an electrojet proxy — different current systems have different geometry.

The crossover frequency may be a natural boundary between convection-driven (large-scale, E-W) and wave-driven (localized, N-S) perturbation regimes.

### Three-Regime Coherence Structure

![Three-Regime Coherence](img/08_three_regime_coherence.png)

Mean coherence between nearby stations (<500 km) shows three distinct regimes:

**Regime 1 (>10 min period): High coherence (>0.8).** Large-scale convection and the R1/R2 current system create highly coherent perturbations. Both X and Z are coherent. X is slightly higher because the electrojet is a continuous sheet — neighboring stations under the same sheet see the same thing.

**Regime 2 (3–10 min period): Coherence dip (0.3–0.5).** [Pc5 pulsations](https://en.wikipedia.org/wiki/Pc5_pulsations) — field line resonances where different L-shells oscillate independently at their own eigenfrequencies. Nearby stations may be on different L-shells and thus see incoherent oscillations. This is where L(f) shows a dip — the coherence is "broken into pieces."

**Regime 3 (<3 min period): Partial recovery (0.5–0.7), X only.** X coherence recovers but **Z does not** (~0.2). This is consistent with [Pi2 pulsations](https://en.wikipedia.org/wiki/Pi2_pulsations) — substorm-associated oscillations that are predominantly horizontal. Pi2 involves cavity/waveguide modes that are coherent over ~200–1,000 km in the horizontal plane but produce minimal vertical signature.

**Caution:** At 1-minute sampling, the 2–3 min period band is near Nyquist. The X-only recovery needs confirmation with 10-sec data.

### Component-Dependent Spatial Structure

Each magnetic field component sees a different current system:

| Component | Moran's I (storm) | Anisotropy (NS/EW γ) | What It Sees |
|---|---|---|---|
| **X (North)** | 0.326 (highest) | 10:1 (E-W sheets) | Electrojet — continuous E-W sheet |
| **Y (East)** | 0.205 | 0.3 (N-S elongated) | FAC polarity reversal across dawn-dusk |
| **Z (Vertical)** | 0.147 (lowest) | 1.0 (isotropic) | FAC filaments — discrete, roughly circular |

Z is the most isotropic because FAC filaments don't have a preferred horizontal orientation — they're vertical currents hitting the ionosphere as roughly circular patches. X is the most anisotropic because the electrojet is a thin E-W sheet.

**Critical insight:** Z coherence **decreases** during storms while X **increases**. Different current systems respond oppositely to driving intensity. The electrojet (X) becomes more coherent as it strengthens (bigger sheet, more uniform). The FAC system (Z) becomes less coherent — more filaments, more complex geometry, more substorm disruptions.


## Part 8: The Observational Philosophy

This project is fundamentally about **observing**. The data has already been captured by magnetometer networks running continuously for decades. We are not running experiments or simulations — we are developing tools to see what is there.

The pipeline combines three independent axes of observation:
- **Spatial** (Moran's I, variogram) → where is the structure?
- **Temporal** (pattern persistence, storm evolution) → when does structure change?
- **Spectral** (L(f), coherence, phase) → at what scales does structure exist?

No single axis is sufficient. Moran's I tells you there IS spatial structure but not at what frequencies. L(f) tells you spatial scale depends on frequency but not where. The variogram tells you correlation length but not whether it changes with time. The three axes together create a view that none achieves alone.

### What We Can See vs. What We Can't

**We CAN see (with current IMAGE 1-min data):**
- Spatial correlation structure at scales 88–2,355 km
- Spectral content from ~2 min (Nyquist) to hours
- Convection, substorm, and Pc5 band spatial structure
- Component-dependent anisotropy → current system identification
- Storm-time evolution of all the above

**We CANNOT yet see:**
- Pi2 band (need 10-sec data — available from FMI, not yet downloaded)
- Pc3 band (need 1-sec data)
- Spatial structure below ~88 km (minimum station spacing)
- Absolute FAC density (need in-situ calibration, e.g., Swarm or MMS conjunction)
- Structures larger than ~2,355 km reliably (network extent limitation)

### Next Steps

1. **10-sec IMAGE data** — Download and analyze to confirm the Regime 3 coherence recovery and resolve the Pi2 band properly
2. **Bayesian SECS cross-validation** — Compare our Tikhonov inversion spatial structure with Käki et al.'s Matérn-prior SECS
3. **Multi-event analysis** — Full pipeline on all 8 catalog events to test universality of L(f) shape and anisotropy reversal
4. **MMS conjunctions** — Search for times when MMS spacecraft pass through IMAGE network field-of-view for ground-truth FAC density

---

*Tutorial generated 2026-05-09. Images in `docs/ms-tutorial/img/`. Analysis pipeline: `scripts/spectral_spatial.py`. Data: FMI IMAGE archive via `scripts/download_image.py`.*
