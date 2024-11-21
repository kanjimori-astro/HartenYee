!This code solves the advection equation with the Harten-Yee scheme.
!Equation numbers are from Fujii "Numerical Methods for Computational Fluid Dynamics".
!See Section 3.4 in Fujii's textbook for details.
program harten_yee
implicit none

real(8)::u(-1:102),u_new(-1:102),f(-1:101),f_mod(0:100),g(0:101),Delta(-1:101),gamma(0:100),sigma,phi(0:100),x(0:100)
real(8)::t,CFL,dx,dt,c
integer::i,n

!Parameters
!=====================================
c   = 1d0
CFL = 0.2	!CFL number
dx  = 1d0
dt  = CFL*dx/c
!=====================================

!Grid generation
!=====================================
do i=1,100
	x(i)=i*dx
end do
!=====================================

!Initial condition
!=====================================
u=0d0
write(*,*) "# n=",0,"t=",0 
do i=10,30
	u(i)=1d0
end do

do i=1,100
	write(*,*) x(i),u(i)
end do
write(*,*)
write(*,*)
!=====================================

t=0d0
do n=1,100

	t = t+dt
	
	do i=-1,101
		Delta(i) = u(i+1)-u(i)
		f(i)     = c*u(i)
	end do

	do i=0,101
		g(i) = sign(1d0,Delta(i))*max(0d0,min(abs(Delta(i)),sign(1d0,Delta(i))*Delta(i-1)))
	end do

	do i=0,100
		sigma = 0.5*(abs(c)-dt/dx*c**2d0)
		if (Delta(i) .ne. 0d0) then
			gamma(i) = sigma*(g(i+1)-g(i))/Delta(i)
		else
			gamma(i) = 0d0
		end if
		phi(i) = sigma*(g(i)+g(i+1))-abs(c+gamma(i))*Delta(i) !Eq. (3.60)
	end do
	
	do i=0,100
		f_mod(i) = 0.5*((f(i)+f(i+1))+phi(i)) !The modified flux defined in Eq. (3.59)
	end do

	if (mod(n,10)==0) write(*,*) "# n=",n,"t=",t 
	do i=1,100
		u_new(i) = u(i)-dt/dx*(f_mod(i)-f_mod(i-1)) !Explicit intergal in Eq. (2.45)
		if (mod(n,10)==0) write(*,*) x(i),u_new(i)
	end do

	if (mod(n,10)==0) then
		write(*,*) 
		write(*,*) 
	end if

	u = u_new

end do

stop
end program