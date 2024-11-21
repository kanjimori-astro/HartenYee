# HartenYee
This code solves the advection equation with Harten-Yee's upwind scheme.

# Introduction
Let us consider the one-dimensional advection equation

$$\frac{\partial u}{\partial t}+c\frac{\partial u}{\partial x}=0.$$

Unfortunately, it is impossible to keep monotonicity of its solutions with linear schemes more accurate than first-order ones because of Godunov's theorem. Instead, nonlinear high resolution schemes have been developed to solve the equation accurately, and Harten-Yee's upwind scheme [e.g. 1,2] is one of them.

In this scheme, the modified flux is defined as

$$\tilde{f}_　{j+1/2}=\frac{1}{2}((f_{j+1}+f_{j})+\phi_{j+1/2}),$$

where 

$$\phi_{j+1/2}=\sigma(c_{j+1/2})(g_j+g_{j+1})-|c_{j+1/2}+\gamma_{j+1/2}|\Delta_{j+1/2},$$
$$\Delta_{j+1/2}=u_{j+1}-u_{j},$$
$$\sigma(z)=\frac{1}{2}\left(|z|-\frac{\Delta t}{\Delta x}z^2\right),$$
$$g_j=\mathrm{minmod}(\Delta_{j+1/2}, \Delta_{j-1/2}).$$

$$\Delta x$$ is the spatial resolution and $$\Delta t$$ is the time step. The modified characteristic velocity is defined as 

$$\gamma_{j+1/2}=\frac{\sigma(c_{j+1/2})(g_{j+1}-g_{j})}{\Delta_{j+1/2}}$$

if $$\Delta_{j+1/2}\neq 0$$, and $$\gamma_{j+1/2}=0$$ if  $$\Delta_{j+1/2}=0$$.

# What the code can do

The code adopts Euler's explicit integral

$$u_j^{n+1}=u_j^n-\frac{\Delta t}{\Delta x}(\tilde{f}_　{j+1/2}-\tilde{f}_　{j-1/2})$$

to obtain the solution at the next time step.

The following figure shows an example of the output for $$c=1$$. One can observe advection towards the positive x-direction without numerical oscillations.
![スクリーンショット 2024-11-21 210059](https://github.com/user-attachments/assets/9275f61b-7e11-4f0a-9c89-2e983c537851)

# References
[1] Yee (1987), NASA Technical Memorandum 89464.

[2] 藤井孝藏 (1994), 『流体力学の数値計算法』, 東京大学出版会.
