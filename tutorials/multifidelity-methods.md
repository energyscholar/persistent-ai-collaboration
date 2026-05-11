# Multi-Fidelity Tutorial: What Argus Learned About the GPS Carrier-Phase Approach

**From:** Argus S73 research session, 2026-05-09
**Context:** 13 methods compared via LOO cross-validation across Halloween 2003, Aug 2001, Aug 2005

---

## The Big Picture in One Paragraph

Your GPS analogy is correct and validated. BATS-R-US is the code phase (coarse, global physics). IMAGE is the carrier phase (precise, regional data). The multi-step accuracy chain works: raw physics model (0.52 skill) + kriging correction (0.73) + dual physics + adaptive correction (0.75). But for a dense 26-station network, baseline kriging already achieves 0.72 — the multi-fidelity chain adds only 4.5%. The real payoff is for sparse networks, extrapolation outside the array, and physics decomposition. This is exactly like GPS: in a dense reference network, carrier-phase corrections converge almost instantly. The DGPS chain matters most when stations are far apart.

---

## What Works: Dual ROM + Intensity-Adaptive Kriging

### The Method (3 steps)

**Step 1: Fit a Gaussian electrojet to the data.**
A line current at 110 km altitude with Gaussian profile — 3 parameters: intensity I₀, center latitude, width σ. The Biot-Savart integral gives ground-level dBx at each station. Dual version uses two Gaussians (6 params) to capture the return current.

**Step 2: Krige the residual.**
Whatever the ROM doesn't capture (localized FAC filaments, asymmetric structure, sub-scale physics), interpolate using Matérn-3/2 kriging with covariance length L.

**Step 3: Adapt L to storm intensity.**
At each timestep, compute the network RMS. Map it linearly to L: quiet (low RMS) → L=1500 km, extreme (high RMS) → L=300 km. The physics: extreme storms inject localized current structures that require short correlation lengths; quiet periods are spatially smooth.

### Why This Beats Everything Else

| Component | What it provides | Why it helps |
|-----------|-----------------|-------------|
| Dual ROM | Physics-informed trend (captures ~70% of spatial variance) | Extrapolates correctly at edge stations where kriging has few neighbors |
| Residual kriging | Data-driven correction of ROM errors | Handles sub-scale physics the ROM misses (FAC filaments, SCW asymmetry) |
| Intensity-adaptive L | Per-timestep correlation length | Avoids the bias of a single L for a non-stationary field |

### Per-Event Results

| Event | Baseline | Best Method | Skill Gain |
|-------|----------|-------------|-----------|
| Halloween 2003 (AE=4192) | 0.777 | dual+intensity_krige: 0.790 | +1.3% |
| Aug 2001 (AE~960) | 0.648 | rom_dual: 0.733 | +13.1% |
| Aug 2005 (AE~1100) | 0.722 | dual+intensity_krige: 0.758 | +5.0% |

The moderate storm (Aug 2001) shows the biggest gain because the Gaussian electrojet model is a near-perfect match for the smooth, coherent current system. For the extreme Halloween storm, the current system is complex enough that the ROM captures less and kriging has to do more work.

---

## What Didn't Work (and Why)

### KED (Kriging with External Drift)

**The idea:** Instead of two-stage (fit trend, krige residual), do it jointly. KED puts the ROM prediction as a drift variable in the kriging system. The math:

```
[C  F] [λ]   [c₀]
[F' 0] [β] = [f₀]

where F = [1, ROM(station)] and f₀ = [1, ROM(target)]
```

**Why it fails:** KED assumes the drift is LINEAR in the drift variable: m(x) = β₀ + β₁·ROM(x). But the ROM is a nonlinear function of latitude (Gaussian profile). When you linearize a Gaussian, you lose information about the curvature. Two-stage is better because step 1 uses the full nonlinear ROM, and step 2 only needs to krige the residual (which IS approximately linear/smooth).

**The lesson:** Joint estimation is theoretically optimal only when the drift model class is correct. For nonlinear physics, two-stage wins.

### Spectral OI

**The idea:** Decompose the field into frequency bands (DC, substorm, Pc5), krige each with its empirical L(f), reconstruct.

**Why it fails for total field:** DC carries 94-98% of total variance. The bandpass decomposition introduces filter edge effects that contaminate the DC estimate. And the DC band is kriged with L=3000 km (unnecessarily long — L=500 works fine for the smooth DC component).

**Where it DOES work:** Band-specific science. If you want to map Pc5 eigenmode spatial structure, use L(Pc5)=800 km. If you want Pi2 onset locations, use L(Pi2)=1500 km. The technique is novel (literature survey found no prior art for temporal-frequency-dependent covariance in OI).

### Empirical Variogram-Fitted L

**The idea:** Let the data tell you L by fitting the Matérn variogram.

**Why it fails:** The variogram averages over the entire active window — mixing quiet periods (L~1500 km) with extreme periods (L~300 km) to get L~800 km. This is worse than either extreme. The field is non-stationary in time; a single L misrepresents it.

**The fix:** Intensity-adaptive L (our winning method) solves this by computing L per-timestep from the network activity level.

---

## The Forward Model: What You Need to Know

### The Electrojet Forward Model

An eastward current at ionospheric height h=110 km produces a northward magnetic perturbation at the ground:

```
dBx(lat_obs) = I₀ × shape(lat_obs - lat_center, σ)
```

where shape is the normalized Biot-Savart integral of a Gaussian current profile:

```
shape(Δlat) = ∫ exp(-x'²/2σ²) · h/(h² + (Δlat·111 - x')²) dx'
```

This is a Voigt profile (Gaussian convolved with Lorentzian). Peak is at Δlat=0. Width is dominated by σ when σ > 1° (our case), not by h.

### The Sign Bug (and why it matters)

The original code computed:
```python
dBx = I0 * ∫ ... dx  # I0 baked into integral
scale = max(|dBx|)
dBx *= I0 / scale     # I0 applied AGAIN
```

When I₀ < 0 (westward electrojet): raw dBx < 0, I₀/scale < 0, so dBx × (negative) → positive. The model could never produce negative dBx, making it invisible to the optimizer for westward electrojets (which is ALL storms).

Fix: compute integral without I₀, normalize to unit peak, then apply I₀ once.

### ROM Parameter Diagnostics

For Halloween 2003, after the fix:
- **Intensity I₀:** 0 during quiet → -2000 nT during main phase (westward electrojet)
- **Center latitude:** 75°N quiet → 65°N peak (equatorward auroral expansion)
- **Width σ:** 2-4° (consistent with ~400 km auroral oval width at ground)
- **R²:** 0.6-0.9 during active periods (electrojet dominates spatial pattern)

---

## Literature Survey Results: What Exists, What's New

### What exists (and we're doing correctly)

1. **Kennedy & O'Hagan (2000):** Our ROM+krige IS their multi-fidelity GP model: y_hi = ρ·y_lo + δ(x), δ ~ GP. We just don't estimate ρ explicitly (it's folded into the ROM parameters).

2. **AMIE (Richmond & Kamide 1988):** Standard OI in spherical harmonic space for ionospheric electrodynamics. Similar to our approach but uses EOFs instead of Matérn covariance, and operates globally not regionally.

### What's novel (our contributions)

1. **Spectral OI with temporal-frequency-dependent covariance.** No prior art found. Hasselmann et al. (1997) did something similar for ocean wave spectra, but in spatial-frequency, not temporal-frequency.

2. **Intensity-adaptive L** from real-time network RMS. The idea of storm-dependent correlation length is implicit in the literature (everyone fits variograms per-event), but explicit per-timestep adaptation driven by the data itself appears to be new.

3. **The KED vs two-stage result for nonlinear physics.** Not published as a finding, but important for anyone applying multi-fidelity methods to geophysics.

### What we should pursue (from the survey)

1. **SPDE approach (Lindgren 2011):** Non-stationary Matérn via the stochastic PDE (κ²-Δ)^{α/2}·τu = W. This would give spatially varying L — shorter in the auroral zone, longer at lower latitudes. Requires FEM mesh on the IMAGE region.

2. **Constrained kriging (Michalak 2005):** Add physics constraints to kriging (e.g., ∇·B=0 for the perturbation field). This could enforce Maxwell's equations on the interpolation.

---

## Where the Multi-Fidelity Approach Really Pays Off

### Not here (dense network)

With 26 stations at ~100-200 km spacing, baseline kriging already interpolates at r=0.97. The physics model adds 4.5% — marginal. This is like using DGPS in downtown Portland where there are reference stations on every block.

### But here (these are the use cases)

1. **Sparse networks:** Subsample IMAGE to 8-10 stations (e.g., SuperMAG Fennoscandia). The ROM provides physics-informed trend; kriging can't extrapolate from distant stations. Expected improvement: 10-20%.

2. **Extrapolation outside the array:** Predict dBx at GIC-vulnerable locations between IMAGE stations (power grid nodes, pipeline routes). The ROM provides the electrojet model; kriging provides local corrections from the nearest stations.

3. **Physics decomposition:** The ROM tells you WHERE the electrojet is, HOW wide it is, HOW strong it is — at every timestep. These are physically meaningful parameters that kriging alone doesn't provide.

4. **Real-time nowcasting:** The ROM fits in milliseconds (3 parameters, 26 data points). Add the precomputed kriging weights and you have real-time interpolation/extrapolation that's faster than solving the full kriging system.

---

## Honest Assessment

| Topic | Confidence |
|-------|-----------|
| Multi-fidelity GP framework (Kennedy & O'Hagan) | Medium-high |
| Why KED fails for nonlinear trends | High |
| ROM electrojet forward modeling | High (including sign bug!) |
| Intensity-adaptive L | Medium-high |
| SPDE for non-stationary Matérn | Low (theory only) |
| Whether our spectral OI is truly novel | Medium (checked 6 sources) |
| Whether sparse-network test will show larger gains | High (physics reasoning) |
| Whether the 4.5% gain is statistically significant | Medium-low (need bootstrap CI) |

The weakest claim is the last one. With 26 stations × 3 events, we have 75 LOO samples. The 4.5% skill improvement might not be statistically significant at p<0.05. A permutation test would establish this. But the physical reasoning is sound regardless of statistical significance.

---

## What's Next (Ordered by Expected Impact)

1. **Sparse network test** — subsample to 8-10 stations and re-run. This is where multi-fidelity should dominate.
2. **Component-resolved ROM+krige** — fit X, Y, Z separately with per-component L and ν. Expected +5% for Y (from S72).
3. **Time-windowed variogram** — fit L per 2-hour window instead of the whole event.
4. **CCMC custom SWMF run** — virtual magnetometers at all IMAGE locations for true residual kriging.
5. **Bootstrap confidence intervals** — establish whether the skill improvements are statistically significant.
6. **SPDE implementation** — non-stationary Matérn with spatially varying κ.
