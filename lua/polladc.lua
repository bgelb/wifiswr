local id, sda, scl = 0, 2, 1
i2c.setup(id, sda, scl, i2c.SLOW)
ads1115.setup(ads1115.ADDR_GND)

local i = 0

local function adc_handler(volt)
    mv_val[i] = volt
    if i == 0 then
        ads1115.setting(ads1115.GAIN_2_048V, ads1115.DR_16SPS, ads1115.SINGLE_1, ads1115.SINGLE_SHOT)
        i = 1
    elseif i == 1 then
        ads1115.setting(ads1115.GAIN_2_048V, ads1115.DR_16SPS, ads1115.SINGLE_2, ads1115.SINGLE_SHOT)
        i = 2
    else
        ads1115.setting(ads1115.GAIN_2_048V, ads1115.DR_16SPS, ads1115.SINGLE_0, ads1115.SINGLE_SHOT)
        i = 0
    end
    ads1115.startread(function(volt, volt_dec, adc) adc_handler(volt) end)   
end

ads1115.setting(ads1115.GAIN_2_048V, ads1115.DR_8SPS, ads1115.SINGLE_0, ads1115.SINGLE_SHOT)
ads1115.startread(function(volt, volt_dec, adc) adc_handler(volt) end)
