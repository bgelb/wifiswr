local mag_db = 0
local phase_deg = 0
local fwd_attn = 40
local ref_attn = 6
local gamma_mag = 0
local gamma_re = 0
local gamma_im = 0
local mag_cp_mv = 942
local mag_slope_mv = 30.7


srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
  conn:on("receive",function(conn,payload)
    conn:send("HTTP/1.0 200 OK\r\nContent-Type: text/html\r\n\r\n")
    mag_db = (mv_val[2]-942)/30.7 + ref_attn - fwd_attn
    phase_deg = (1800 - mv_val[0])/10
    if phase_deg < 0 then phase_deg = 0 end
    gamma_mag = 10^(mag_db/20)
    gamma_re = gamma_mag * fcos(phase_deg)
    gamma_im = gamma_mag * fsin(phase_deg)
    gamma_complex = {gamma_re, gamma_im}
    vswr = math.abs((1+gamma_mag)/(1-gamma_mag))
    Z_complex = cmul({50,0}, cdiv(cadd({1,0}, gamma_complex), csub({1,0}, gamma_complex)))
    conn:send("<head><meta http-equiv=\"refresh\" content=\"2\"></head><h1>SWR Meter</h1>")
    conn:send("Return Loss: " .. tostring(mag_db) .."dB<br>")
    conn:send("Gamma Magnitude: " .. tostring(gamma_mag) .. "<br>")
    conn:send("Gamma Phase: +/-" .. tostring(phase_deg) .. "deg<br>")
    conn:send("VSWR: " .. tostring(vswr) .. "<br>")
    conn:send("Z: " .. tostring(Z_complex[1]) .. " +/- j" .. tostring(Z_complex[2]) .. " ohm<br>")
    conn:send("Debug: Vphase: " .. tostring(mv_val[0]) .. " Vref: " .. tostring(mv_val[1]) .. " Vmag: " .. tostring(mv_val[2]) .."<br>")
  end)
  conn:on("sent",function(conn) conn:close() end)
end)
