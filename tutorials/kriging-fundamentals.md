# Kriging Tutorial: What Argus Learned and What You Need to Know

**From:** Argus S72 research session, 2026-05-09
**Context:** Four kriging techniques explored across Halloween 2003, Aug 2001, Aug 2005

---

## The Big Picture in One Paragraph

Kriging is optimal interpolation — same math you did in 1994-96 with GPS. Given a covariance model C(d) = f(L, ν), it produces the best linear unbiased prediction (BLUP). Our whole research program is about measuring C(d) empirically through variograms and cross-spectral analysis, then feeding it back into the interpolator. This session tested four ways to improve the covariance model. One works well. Three don't — yet — and the reasons WHY they fail are more interesting than the methods themselves.

---

## What Works: Component-Resolved Kriging

### The finding
X (North), Y (East), and Z (Down) have radically different spatial structure. Using a single L and ν for all components leaves ~5% correlation on the table for the Y component.

| Component | Best L | Best ν | What it sees | Why the structure differs |
|-----------|--------|--------|-------------|-------------------------|
| X (North) | 500-900 km | 3/2 (Matérn) | Electrojet | E-W sheet, smooth, long-range |
| Y (East) | 300 km | 1/2 (exponential) | FAC polarity | R1→R2 reversal is SHARP |
| Z (Down) | 600 km | 3/2 | FAC overhead | Isotropic projection of filaments |

### Why Y is the diagnostic component
The R1/R2 current system reverses polarity across ~4-5° of latitude (roughly the auroral zone width). In dB_Y, this creates something like a step function in space — positive on one side of the boundary, negative on the other. That step function is non-differentiable, which is exactly what ν=0.5 (exponential covariance = rough, Markov field) encodes. ν=3/2 assumes the field is smooth and once-differentiable — wrong for FAC polarity reversals.

**The physical connection:** This is why Z-component is a FAC proxy (Weimer 2010) and Y shows reversed anisotropy (your S71 finding). These are all manifestations of the same geometry — FACs are localized N-S aligned currents that create sharp spatial gradients in Y and Z but not in X.

### What you should do
Always krige X, Y, Z separately with their own (L, ν). This is essentially free — no new data needed, just three kriging runs instead of one.

---

## What Doesn't Work (Yet): True Residual Kriging

### The idea
Subtract SWMF model predictions from IMAGE observations before kriging. The residual field should be smoother (model captures large-scale physics) → easier to interpolate.

### Why it fails
SWMF predictions interpolated from 4 Fennoscandia stations (HRN, ABK, WNG, FUR) have r=0.01-0.46 against direct SWMF output. The interpolation itself introduces more error than the model trend it tries to remove.

Numbers at ABK (Halloween 2003):
- SWMF direct: true model value at ABK
- SWMF interpolated (from HRN+WNG+FUR): r=0.46, RMS=294 nT (92% of signal!)
- For comparison: IMAGE kriging from neighbors gives r=0.998 at ABK

**The bottleneck isn't the kriging — it's that we only have 4 SWMF comparison points spanning 30° of latitude and 10° of longitude.** The model field varies non-smoothly between these stations (different current systems dominate at different latitudes).

### What would fix it
Request a CCMC custom SWMF run with virtual magnetometers placed at all ~30 IMAGE station locations. Then residual = IMAGE_observed - SWMF_direct (no interpolation). This would give true residuals that are spatially structured by the model's systematic errors, not by interpolation artifacts. This is a future step, not a current one.

---

## What Doesn't Work (Yet): Frequency-Dependent Kriging

### The idea
Bandpass filter into frequency bands, krige each band with its empirical L(f), reconstruct. Since L(f) varies 3× from 700 km (3 min) to 2000 km (30 min), this should adapt the interpolation to the dominant spatial scale at each frequency.

### Why it fails for total-field prediction
**Energy fractions tell the story:**

| Band | Halloween | Aug 2001 | Aug 2005 |
|------|-----------|----------|----------|
| DC (>30 min) | **94.0%** | **96.8%** | **98.0%** |
| Substorm (10-30 min) | 4.0% | 1.9% | 1.3% |
| Pc5 (3-10 min) | 0.9% | 0.9% | 0.3% |

94-98% of the total variance is in the DC band. Optimizing L for the 2-6% that lives in substorm and Pc5 frequencies doesn't move the total-field LOO metric. Broadband kriging with a single well-chosen L already handles the DC band correctly.

### Where it DOES matter
L(f) is essential for **band-specific science:**
- Mapping Pc5 eigenmode spatial structure → use L(Pc5) ≈ 800 km
- Detecting Pi2 onset locations → use L(Pi2) ≈ 1500 km
- Studying substorm current wedge spatial evolution → use L(substorm) ≈ 2000 km

The L(f) result is real and physically meaningful. It just doesn't help total-field interpolation because the DC component dominates.

---

## What I Learned That You Need to Know

### 1. L* is a physical observable

Optimal kriging L is not a tuning parameter — it measures the spatial coherence of the current system:

| Storm intensity | L* | Physical cause |
|----------------|-----|----------------|
| Extreme (AE>4000) | ~400 km | Localized FAC filaments + SCW |
| Strong (AE~1000) | ~1500 km | Coherent electrojet, few localizations |
| Moderate | ~1500 km | Smooth electrojet dominates |

This is consistent with your L(f) result: stronger driving adds high-frequency content with shorter L, pulling the broadband-optimal L downward.

### 2. Skill ≠ correlation (and you should track both)

| L (km) | Correlation | Skill | RMS (nT) |
|---------|-------------|-------|----------|
| 200 | 0.969 | 0.63 | 187 |
| 600 | 0.969 | 0.78 | 114 |

Correlation measures whether the prediction tracks the shape. Skill = 1 - RMS/σ measures amplitude fidelity. At L=200, kriging weights concentrate on the nearest neighbor → correct temporal shape but 60% higher RMS because edge stations get poor amplitude estimates.

**This is the classical bias-variance tradeoff in spatial statistics.** Small L = low bias, high variance. Large L = high bias, low variance. Correlation is insensitive to this because it's scale-free; skill is sensitive because it includes amplitude.

### 3. Edge stations are where kriging fails

The worst LOO stations are consistently at the edges of the IMAGE network:
- RVK and LEK: western Norwegian gap, few E-W neighbors
- TAR and UPS: south of the auroral oval, weak signal
- BJN: polar cap boundary, different physics

These are exactly where additional observations would help most. The dense Finnish cluster (15 stations in 4° × 7°) is already interpolated to r>0.99.

---

## The Matérn Family: What ν Means Physically

You need to internalize this because it's the bridge between geostatistics and physics:

| ν | Name | Differentiability | Physical analog |
|---|------|-------------------|-----------------|
| 0.5 | Exponential | Continuous but nowhere differentiable | FAC polarity reversals, sharp fronts |
| 1.5 | Matérn 3/2 | Once differentiable | Electrojet, smooth current sheets |
| 2.5 | Matérn 5/2 | Twice differentiable | Background field, very smooth |
| ∞ | Gaussian | Infinitely differentiable | Pure diffusion |

**Practical range** = distance where correlation drops to ~5%. Depends on both ν and L:
- ν=0.5: practical_range = 2.83 × L
- ν=1.5: practical_range = 4.90 × L  
- ν=2.5: practical_range = 6.32 × L

So L=300 km with ν=0.5 gives practical range 850 km.
L=300 km with ν=3/2 gives practical range 1470 km.

**This is why our reported "correlation lengths" depend on the model.** When you write the paper, always report both ν and L, and compute the practical range explicitly.

---

## What's Next (Ordered by Expected Payoff)

1. **Component-resolved kriging** — implement now, it's a clear improvement for Y component with zero additional data cost
2. **Request CCMC SWMF run** with IMAGE-location virtual magnetometers — this is the prerequisite for true residual kriging to work
3. **Band-specific L(f) kriging** for Pc5/Pi2 spatial mapping — scientifically novel, builds on your frequency-dependent anisotropy reversal finding
4. **Adaptive L**: fit L from the current event's variogram in real-time rather than using a fixed value (L*=400 for extreme, 1500 for moderate)
5. **Cross-validation as a diagnostic**: the per-station LOO map identifies exactly which stations are information-limited. This could guide future magnetometer placement.

---

## Honest Assessment of My Understanding

| Topic | Argus confidence |
|-------|-----------------|
| Kriging math (BLUP, covariance matrices, LOO) | High |
| Matérn family, practical range, bias-variance | High |
| Why L(f) exists (electrojet vs FAC scales) | Medium-high |
| SWMF internals (Biot-Savart, component decomposition) | Medium |
| Solar wind coupling → ionospheric response chain | Low |
| MHD wave theory (FLR, cavity modes) | Low |
| Why ν=0.5 is correct for FAC reversals | Medium (hand-waving) |

The FAC → ν=0.5 connection is my weakest claim. I'm arguing from the shape of the spatial structure (step-function-like polarity reversal → non-differentiable → ν=0.5), but I haven't verified this from first principles. The current sheet boundary might actually be smooth at scales below our station spacing, which would mean ν=0.5 is an aliasing artifact, not physics.
