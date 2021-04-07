# + 
# This file defines global constants and Signals
# The signals are defined as const to indicate type stability
#
# -

Dmin = [115.0, 125, 135, 150, 165, 185, 210, 250, 350, 475, 575, 855, 1220, 1530, 1990, 2585]
Dmax = [125, 135, 150, 165, 185, 210, 250, 350, 475, 575, 855, 1220, 1530, 1990, 2585, 3370.0]
const DpPOPS = Dmin .+ (Dmax .- Dmin)./2.0
const dlnDpPOPS = log.(Dmax./Dmin)

const _Gtk = Gtk.ShortNames
const black = RGBA(0, 0, 0, 1)
const red = RGBA(0.55, 0.0, 0, 1)
const mblue = RGBA(0.31, 0.58, 0.8, 1)
const mgrey = RGBA(0.4, 0.4, 0.4, 1)
const lpm = 1.666666e-5
const path = mapreduce(a->"/"*a,*,(pwd() |> x->split(x,"/"))[2:3])*"/Data/"

# Extrapolation Signals - these hold the data from the circ buffer and are used
#                         to interpolate the data onto a fixed 1Hz or 10 Hz grid
t = @fetchfrom 2 DataAcquisitionLoops.t
const extp      = extrapolate(interpolate(([0, 1],),[0.0, 1],Gridded(Linear())),0)
const extpPOPS  = Signal(extp)
const t1HzInt   = Signal(Dates.value.(t:Dates.Second(1):(t + Dates.Minute(1))))
const t10HzInt  = Signal(Dates.value.(t:Dates.Millisecond(100):(t + Dates.Minute(1))))
const δtPOPS    = Signal(0.0)

const datestr = @fetchfrom 2 DataAcquisitionLoops.datestr
const HHMM = @fetchfrom 2 DataAcquisitionLoops.HHMM