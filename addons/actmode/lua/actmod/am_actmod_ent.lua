A_AM.ActMod.LuaEnt = true
A_AdPa = {
    AddParticle = function(gN, gP)
        game.AddParticles(gN)
        for _, v in ipairs(gP) do
            PrecacheParticleSystem(v)
        end
    end
}

A_AdPa.AddParticle("particles/portal_projectile.pcf", {"portal_1_badsurface", "portal_1_badsurface_", "portal_1_badvolume", "portal_1_badvolume_", "portal_1_cleanser", "portal_1_near", "portal_1_near_in", "portal_1_near_out", "portal_1_near_warp", "portal_1_nofit", "portal_1_nofit_warp", "portal_1_overlap", "portal_1_overlap__", "portal_1_overlap_glow", "portal_1_overlap_glow_nomove", "portal_1_overlap_oval", "portal_1_overlap_warp", "portal_1_overlap_warp_fast", "portal_1_projectile_3rdperson", "portal_1_projectile_ball", "portal_1_projectile_ball_3rdperson", "portal_1_projectile_fiber", "portal_1_projectile_stream", "portal_1_projectile_stream_pedestal", "portal_1_projectile_trail", "portal_1_success", "portal_2_badsurface", "portal_2_badsurface_", "portal_2_badvolume", "portal_2_badvolume_", "portal_2_cleanser", "portal_2_cleanser_old", "portal_2_near", "portal_2_near_in", "portal_2_near_out", "portal_2_nofit", "portal_2_overlap", "portal_2_overlap_", "portal_2_projectile_3rdperson", "portal_2_projectile_ball", "portal_2_projectile_ball_3rdperson", "portal_2_projectile_fiber", "portal_2_projectile_stream", "portal_2_projectile_stream_pedestal", "portal_2_projectile_trail", "portal_2_success"})
if CLIENT then
    local EFFECT = {}
    function EFFECT:Init(data)
        local ent = data:GetOrigin()
        local emitter = ParticleEmitter(ent)
        self.Particle = emitter:Add("actmod/eff_particle/p_i_ligtstar_0" .. math.random(0, 1), ent)
        self.Particle:SetVelocity(VectorRand() * 25)
        self.Particle:SetAirResistance(math.Rand(50, 100))
        self.Particle:SetDieTime(math.random(0.2, 0.4))
        self.Particle:SetStartAlpha(255)
        self.Particle:SetEndAlpha(0)
        self.Particle:SetStartSize(math.random(2, 4))
        self.Particle:SetEndSize(math.random(4, 1))
        self.Particle:SetRoll(math.random(-90, 90))
        emitter:Finish()
        if math.random(3) == 2 then
            local emitter = ParticleEmitter(ent)
            self.Particle = emitter:Add("actmod/eff_particle/p_i_ligtstar_0" .. math.random(0, 3), ent)
            self.Particle:SetVelocity(VectorRand() * 20)
            self.Particle:SetDieTime(math.random(0.1, 0.4))
            self.Particle:SetStartAlpha(255)
            self.Particle:SetEndAlpha(0)
            self.Particle:SetStartSize(math.random(1, 6))
            self.Particle:SetEndSize(math.random(6, 1))
            self.Particle:SetColor(math.random(255), math.random(255), math.random(255))
            emitter:Finish()
        end
    end

    function EFFECT:Think()
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_kpop_02_e1", true)
    local EFFECT = {}
    function EFFECT:Init(data)
        local ent = data:GetOrigin()
        local emitter = ParticleEmitter(ent)
        self.Particle = emitter:Add("actmod/eff_particle/p_ring_wave", ent)
        self.Particle:SetDieTime(0.5)
        self.Particle:SetStartAlpha(255)
        self.Particle:SetEndAlpha(0)
        self.Particle:SetStartSize(5)
        self.Particle:SetEndSize(10)
        self.Particle:SetColor(255, 255, 255)
        emitter:Finish()
        local emitter = ParticleEmitter(ent)
        self.Particle = emitter:Add("actmod/eff_particle/p_glow_02", ent)
        self.Particle:SetDieTime(0.2)
        self.Particle:SetStartAlpha(255)
        self.Particle:SetEndAlpha(0)
        self.Particle:SetStartSize(10)
        self.Particle:SetEndSize(5)
        self.Particle:SetColor(255, 255, 255)
        emitter:Finish()
        for i = 1, math.random(10, 20) do
            local emitter = ParticleEmitter(ent)
            self.Particle = emitter:Add("actmod/eff_particle/p_glow_03", ent)
            self.Particle:SetVelocity(Vector(0, 0, 30) + VectorRand() * 100)
            self.Particle:SetAirResistance(math.Rand(200, 600))
            self.Particle:SetDieTime(math.random(0.4, 0.6))
            self.Particle:SetStartAlpha(255)
            self.Particle:SetEndAlpha(0)
            self.Particle:SetStartSize(math.random(2, 10))
            self.Particle:SetEndSize(math.random(10, 2))
            self.Particle:SetColor(math.random(255), math.random(255), math.random(255))
            self.Particle:SetRoll(math.Rand(-1, 1))
            self.Particle:SetCollide(false)
            emitter:Finish()
        end
    end

    function EFFECT:Think()
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_kpop_02_e2")
    local EFFECT = {}
    function EFFECT:Init(data)
        for i = 1, math.random(2, 6) do
            local ent = data:GetOrigin()
            local emitter = ParticleEmitter(ent)
            self.Particle = emitter:Add("actmod/eff_particle/p_i_ligtstar_0" .. math.random(0, 1), ent)
            self.Particle:SetDieTime(0.4)
            self.Particle:SetStartAlpha(255)
            self.Particle:SetEndAlpha(0)
            self.Particle:SetStartSize(5)
            self.Particle:SetEndSize(6)
            emitter:Finish()
            if math.random(3) == 2 then
                local emitter = ParticleEmitter(ent)
                self.Particle = emitter:Add("actmod/eff_particle/p_i_ligtstar_0" .. math.random(0, 3), ent)
                self.Particle:SetVelocity(VectorRand() * 150)
                self.Particle:SetAirResistance(math.Rand(200, 600))
                self.Particle:SetDieTime(math.random(0.1, 0.4))
                self.Particle:SetStartAlpha(255)
                self.Particle:SetEndAlpha(0)
                self.Particle:SetStartSize(math.random(1, 6))
                self.Particle:SetEndSize(math.random(6, 1))
                self.Particle:SetColor(math.random(255, 255), math.random(200, 255), math.random(200, 255))
                self.Particle:SetRoll(math.random(-90, 90))
                emitter:Finish()
            end
        end
    end

    function EFFECT:Think()
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_kpop_02_e3", true)
    local EFFECT = {}
    function EFFECT:Init(data)
        local ent = data:GetOrigin()
        local emitter = ParticleEmitter(ent)
        self.Particle = emitter:Add("actmod/eff_particle/p_i_ligtstar_0" .. math.random(0, 1), ent)
        self.Particle:SetVelocity(VectorRand() * 25)
        self.Particle:SetAirResistance(math.Rand(50, 100))
        self.Particle:SetDieTime(math.random(0.2, 0.4))
        self.Particle:SetStartAlpha(255)
        self.Particle:SetEndAlpha(0)
        self.Particle:SetStartSize(math.random(2, 4))
        self.Particle:SetEndSize(math.random(4, 1))
        self.Particle:SetRoll(math.random(-90, 90))
        emitter:Finish()
        if math.random(3) == 2 then
            local emitter = ParticleEmitter(ent)
            self.Particle = emitter:Add("actmod/eff_particle/p_i_ligtstar_0" .. math.random(0, 3), ent)
            self.Particle:SetVelocity(VectorRand() * 20)
            self.Particle:SetDieTime(math.random(0.2, 0.4))
            self.Particle:SetStartAlpha(255)
            self.Particle:SetEndAlpha(0)
            self.Particle:SetStartSize(math.random(1, 6))
            self.Particle:SetEndSize(math.random(6, 1))
            self.Particle:SetColor(math.random(255), math.random(255), math.random(255))
            emitter:Finish()
        end

        if math.random(5) == 2 then
            local emitter = ParticleEmitter(ent)
            self.Particle = emitter:Add("actmod/eff_particle/p_i_star_0" .. math.random(1, 4), ent)
            self.Particle:SetVelocity(VectorRand() * 5)
            self.Particle:SetDieTime(math.random(0.3, 0.5))
            self.Particle:SetStartAlpha(255)
            self.Particle:SetEndAlpha(0)
            self.Particle:SetStartSize(math.random(1, 6))
            self.Particle:SetEndSize(math.random(6, 1))
            self.Particle:SetColor(math.random(255), math.random(255), math.random(255))
            emitter:Finish()
        end
    end

    function EFFECT:Think()
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_kpop_04_e1", true)
    local EFFECT = {}
    function EFFECT:Init(data)
        local ent = data:GetOrigin()
        local emitter = ParticleEmitter(ent)
        self.Particle = emitter:Add("actmod/eff_particle/p_i_love_01", ent + Vector(0, 0, -15))
        self.Particle:SetVelocity(Vector(0, 0, 50))
        self.Particle:SetDieTime(0.4)
        self.Particle:SetStartAlpha(255)
        self.Particle:SetEndAlpha(0)
        self.Particle:SetStartSize(2)
        self.Particle:SetEndSize(15)
        self.Particle:SetColor(255, 255, 255)
        emitter:Finish()
        for i = 1, math.random(10, 20) do
            local emitter = ParticleEmitter(ent)
            self.Particle = emitter:Add("actmod/eff_particle/p_i_ligtstar_0" .. math.random(0, 1), ent + Vector(0, 0, -15))
            self.Particle:SetVelocity(Vector(0, 0, 150) + VectorRand() * 200)
            self.Particle:SetAirResistance(math.Rand(200, 600))
            self.Particle:SetDieTime(math.random(0.2, 0.6))
            self.Particle:SetStartAlpha(255)
            self.Particle:SetEndAlpha(0)
            self.Particle:SetStartSize(math.random(1, 3))
            self.Particle:SetEndSize(math.random(3, 1))
            self.Particle:SetColor(255, 255, 255)
            self.Particle:SetRoll(math.Rand(-1, 1))
            self.Particle:SetGravity(Vector(0, 0, 100))
            self.Particle:SetCollide(false)
            emitter:Finish()
        end
    end

    function EFFECT:Think()
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_kpop_04_e2", true)
    local EFFECT = {}
    function EFFECT:Init(data)
        local ent = data:GetOrigin()
        local emitter = ParticleEmitter(ent)
        self.Particle = emitter:Add("actmod/eff_particle/p_glow_01", ent)
        self.Particle:SetDieTime(0.3)
        self.Particle:SetStartAlpha(255)
        self.Particle:SetEndAlpha(0)
        self.Particle:SetStartSize(8)
        self.Particle:SetEndSize(5)
        self.Particle:SetColor(255, 105, 255)
        emitter:Finish()
        for i = 1, math.random(2, 5) do
            local emitter = ParticleEmitter(ent)
            self.Particle = emitter:Add("actmod/eff_particle/p_glow_03", ent)
            self.Particle:SetVelocity(VectorRand() * 50)
            self.Particle:SetAirResistance(math.Rand(200, 600))
            self.Particle:SetDieTime(math.random(0.1, 0.3))
            self.Particle:SetStartAlpha(155)
            self.Particle:SetEndAlpha(0)
            self.Particle:SetStartSize(math.random(2, 10))
            self.Particle:SetEndSize(math.random(10, 2))
            self.Particle:SetColor(255, 105, 255)
            self.Particle:SetRoll(math.Rand(-1, 1))
            self.Particle:SetGravity(Vector(0, 0, 20))
            self.Particle:SetCollide(false)
            emitter:Finish()
        end
    end

    function EFFECT:Think()
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_kpop_04_e3", true)
    local EFFECT = {}
    function EFFECT:Init(data)
        local ent = data:GetOrigin()
        local emitter = ParticleEmitter(ent)
        self.Particle = emitter:Add("actmod/eff_particle/p_ring_wave", ent)
        self.Particle:SetDieTime(0.5)
        self.Particle:SetStartAlpha(255)
        self.Particle:SetEndAlpha(0)
        self.Particle:SetStartSize(5)
        self.Particle:SetEndSize(20)
        self.Particle:SetColor(255, 255, 255)
        emitter:Finish()
        local emitter = ParticleEmitter(ent)
        self.Particle = emitter:Add("actmod/eff_particle/p_glow_02", ent)
        self.Particle:SetDieTime(0.2)
        self.Particle:SetStartAlpha(255)
        self.Particle:SetEndAlpha(0)
        self.Particle:SetStartSize(20)
        self.Particle:SetEndSize(5)
        self.Particle:SetColor(255, 255, 255)
        emitter:Finish()
        for i = 1, math.random(10, 20) do
            local emitter = ParticleEmitter(ent)
            self.Particle = emitter:Add("actmod/eff_particle/p_glow_03", ent)
            self.Particle:SetVelocity(Vector(0, 0, 30) + VectorRand() * 200)
            self.Particle:SetAirResistance(math.Rand(200, 600))
            self.Particle:SetDieTime(math.random(0.4, 0.6))
            self.Particle:SetStartAlpha(255)
            self.Particle:SetEndAlpha(0)
            self.Particle:SetStartSize(math.random(2, 10))
            self.Particle:SetEndSize(math.random(10, 2))
            self.Particle:SetColor(math.random(255), math.random(255), math.random(255))
            self.Particle:SetRoll(math.Rand(-1, 1))
            self.Particle:SetGravity(Vector(0, 0, 100))
            self.Particle:SetCollide(false)
            emitter:Finish()
        end
    end

    function EFFECT:Think()
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_kpop_04_e4", true)
    local EFFECT = {}
    function EFFECT:Init(data)
        local ent = data:GetOrigin()
        for i = 1, math.random(1, 2) do
            local emitter = ParticleEmitter(ent)
            self.Particle = emitter:Add("actmod/eff_particle/shgr_" .. math.random(1, 2), ent)
            self.Particle:SetVelocity(Vector(0, 0, 20) + VectorRand() * 50)
            self.Particle:SetAirResistance(math.Rand(200, 600))
            self.Particle:SetDieTime(math.random(0.6, 1.3))
            self.Particle:SetStartAlpha(255)
            self.Particle:SetEndAlpha(0)
            local sr = math.random(0.3, 1.2)
            self.Particle:SetStartSize(sr)
            self.Particle:SetEndSize(sr)
            self.Particle:SetColor(math.random(50, 80), math.random(50, 60), 20)
            self.Particle:SetRoll(math.Rand(-1, 1))
            self.Particle:SetGravity(Vector(0, 0, -100))
            self.Particle:SetCollide(true)
            emitter:Finish()
        end
    end

    function EFFECT:Think()
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_chelead_e1", true)
    local EFFECT = {}
    function EFFECT:Init(data)
        local ent = data:GetOrigin()
        for i = 1, math.random(3, 7) do
            local emitter = ParticleEmitter(ent)
            if emitter and IsValid(emitter) then
                self.Particle = emitter:Add("actmod/eff_particle/shgr_" .. math.random(1, 2), ent)
                self.Particle:SetVelocity(Vector(0, 0, 30) + VectorRand() * 100)
                self.Particle:SetAirResistance(math.Rand(200, 600))
                self.Particle:SetDieTime(math.random(0.4, 0.6))
                self.Particle:SetStartAlpha(255)
                self.Particle:SetEndAlpha(0)
                local sr = math.random(0.3, 1.2)
                self.Particle:SetStartSize(sr)
                self.Particle:SetEndSize(sr)
                self.Particle:SetColor(math.random(50, 80), math.random(50, 60), 20)
                self.Particle:SetRoll(math.Rand(-1, 1))
                self.Particle:SetGravity(Vector(0, 0, -100))
                self.Particle:SetCollide(false)
                emitter:Finish()
            end
        end
    end

    function EFFECT:Think()
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_chelead_e2", true)
    local EFFECT = {}
    function EFFECT:Init(data)
        local ent = data:GetOrigin()
        for i = 1, math.random(12, 20) do
            local emitter = ParticleEmitter(ent)
            self.Particle = emitter:Add("particles/smokey", ent)
            self.Particle:SetVelocity(Vector(0, 0, 120) + VectorRand() * 60)
            self.Particle:SetAirResistance(math.Rand(200, 600))
            self.Particle:SetDieTime(math.random(0.5, 0.7))
            self.Particle:SetStartAlpha(255)
            self.Particle:SetEndAlpha(0)
            self.Particle:SetStartSize(math.random(1, 7))
            self.Particle:SetEndSize(math.random(8, 1))
            self.Particle:SetColor(math.random(50, 80), math.random(50, 60), 20)
            self.Particle:SetRoll(math.Rand(-1, 1))
            self.Particle:SetGravity(Vector(0, 0, -200))
            self.Particle:SetCollide(true)
            emitter:Finish()
        end
    end

    function EFFECT:Think()
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_toudo_dance", true)
    local EFFECT = {}
    function EFFECT:Init(data)
        local ent = data:GetOrigin()
        local emitter = ParticleEmitter(ent)
        self.Particle = emitter:Add("actmod/eff_particle/p_i_ligtstar_00", ent)
        self.Particle:SetVelocity(Vector(0, 0, 0))
        self.Particle:SetDieTime(math.random(0.5, 0.7))
        self.Particle:SetStartAlpha(255)
        self.Particle:SetEndAlpha(0)
        self.Particle:SetStartSize(15)
        self.Particle:SetEndSize(3)
        self.Particle:SetRoll(math.Rand(-1, 1))
        self.Particle:SetGravity(Vector(0, 0, -20))
        for i = 1, math.random(12, 20) do
            local emitter = ParticleEmitter(ent)
            self.Particle = emitter:Add("actmod/eff_particle/p_glow_0" .. math.random(1, 2), ent)
            self.Particle:SetVelocity(Vector(0, 0, 120) + VectorRand() * 60)
            self.Particle:SetAirResistance(math.Rand(200, 600))
            self.Particle:SetDieTime(math.random(0.2, 0.5))
            self.Particle:SetStartAlpha(255)
            self.Particle:SetEndAlpha(0)
            self.Particle:SetStartSize(math.random(1, 7))
            self.Particle:SetEndSize(math.random(8, 1))
            self.Particle:SetColor(math.random(0, 255), math.random(0, 255), math.random(0, 255))
            self.Particle:SetRoll(math.Rand(-1, 1))
            self.Particle:SetGravity(Vector(0, 0, -200))
            self.Particle:SetCollide(true)
            emitter:Finish()
        end
    end

    function EFFECT:Think()
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_cerealbox", true)
    local EFFECT = {}
    function EFFECT:Init(data)
        local ent = data:GetOrigin()
        for i = 1, math.random(1, 3) do
            local emitter = ParticleEmitter(ent)
            self.Particle = emitter:Add("actmod/eff_particle/p_glow_01", ent)
            self.Particle:SetVelocity(Vector(0, 0, -10) + VectorRand() * 30)
            self.Particle:SetAirResistance(math.Rand(100, 400))
            self.Particle:SetDieTime(math.random(0.3, 0.5))
            self.Particle:SetStartAlpha(255)
            self.Particle:SetEndAlpha(0)
            self.Particle:SetStartSize(2)
            self.Particle:SetEndSize(1)
            self.Particle:SetColor(math.random(255, 244), math.random(255, 244), 20)
            self.Particle:SetRoll(math.Rand(-1, 1))
            self.Particle:SetGravity(Vector(0, 0, -550))
            self.Particle:SetCollide(true)
            emitter:Finish()
        end
    end

    function EFFECT:Think()
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_1cerealbox", true)
    local EFFECT = {}
    function EFFECT:Init(data)
        local ent = data:GetOrigin()
        for i = 1, math.random(1, 3) do
            local emitter = ParticleEmitter(ent)
            self.Particle = emitter:Add("actmod/eff_particle/p_glow_01", ent)
            self.Particle:SetVelocity(Vector(0, 0, 50) + VectorRand() * 30)
            self.Particle:SetAirResistance(math.Rand(100, 400))
            self.Particle:SetDieTime(math.random(0.3, 0.5))
            self.Particle:SetStartAlpha(255)
            self.Particle:SetEndAlpha(0)
            self.Particle:SetStartSize(2)
            self.Particle:SetEndSize(1)
            self.Particle:SetColor(math.random(255, 244), math.random(255, 244), 20)
            self.Particle:SetRoll(math.Rand(-1, 1))
            self.Particle:SetGravity(Vector(0, 0, -200))
            self.Particle:SetCollide(true)
            emitter:Finish()
        end
    end

    function EFFECT:Think()
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_2cerealbox", true)
    local EFFECT = {}
    function EFFECT:Init(data)
        local ent = data:GetOrigin()
        local emitter = ParticleEmitter(ent)
        local mat = "actmod/eff_particle/icmoney_v2"
        if math.random(1, 2) == 2 then mat = "actmod/eff_particle/icmoney2_v2" end
        self.Particle = emitter:Add(mat, ent)
        self.Particle:SetVelocity(Vector(0, 0, 140) + VectorRand() * 60)
        self.Particle:SetAirResistance(math.Rand(200, 600))
        self.Particle:SetDieTime(math.random(0.7, 1.5))
        self.Particle:SetStartAlpha(255)
        self.Particle:SetEndAlpha(0)
        self.Particle:SetStartSize(3)
        self.Particle:SetEndSize(3)
        self.Particle:SetRoll(math.Rand(-1, 1))
        self.Particle:SetGravity(Vector(0, 0, -550))
        self.Particle:SetCollide(true)
        emitter:Finish()
    end

    function EFFECT:Think()
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_make_rain_v2", true)
    local EFFECT = {}
    function EFFECT:Init(ed)
        local vOrig = ed:GetOrigin()
        self.Emitter = ParticleEmitter(vOrig)
        for i = 1, 7 do
            local sparks = self.Emitter:Add("effects/spark", vOrig)
            if sparks then
                sparks:SetColor(100, 200, 255)
                sparks:SetVelocity(Vector(math.random(-130, 130), math.random(-130, 130), math.random(50, 100)))
                sparks:SetDieTime(math.Rand(0.3, 0.7))
                sparks:SetLifeTime(math.Rand(0.4, 0.4))
                sparks:SetStartSize(6)
                sparks:SetStartAlpha(255)
                sparks:SetStartLength(13)
                sparks:SetEndLength(5)
                sparks:SetEndSize(5)
                sparks:SetEndAlpha(255)
                sparks:SetGravity(Vector(0, 0, -150))
            end
        end

        local sparks2 = self.Emitter:Add("effects/strider_muzzle", vOrig)
        if sparks2 then
            sparks2:SetVelocity(Vector(-1, 0, 0))
            sparks2:SetColor(150, 200, 255)
            sparks2:SetDieTime(0.1)
            sparks2:SetStartSize(10)
            sparks2:SetStartAlpha(255)
            sparks2:SetEndSize(25)
            sparks2:SetEndAlpha(0)
            sparks2:SetRoll(math.Rand(-1, 1))
        end
    end

    function EFFECT:Think()
        return false
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_elecfle2_01", true)
    local EFFECT = {}
    function EFFECT:Init(data)
        local ent = data:GetOrigin()
        local emitter = ParticleEmitter(ent)
        self.Particle = emitter:Add("actmod/eff_particle/p_glow_01", ent)
        self.Particle:SetDieTime(0.2)
        self.Particle:SetStartAlpha(255)
        self.Particle:SetEndAlpha(0)
        self.Particle:SetStartSize(8)
        self.Particle:SetEndSize(1)
        self.Particle:SetColor(100, 200, 255)
        emitter:Finish()
        for i = 1, math.random(2, 5) do
            local emitter = ParticleEmitter(ent)
            self.Particle = emitter:Add("actmod/eff_particle/p_glow_03", ent)
            self.Particle:SetVelocity(VectorRand() * 10)
            self.Particle:SetAirResistance(math.Rand(200, 600))
            self.Particle:SetDieTime(0.4)
            self.Particle:SetStartAlpha(155)
            self.Particle:SetEndAlpha(0)
            self.Particle:SetStartSize(math.random(2, 10))
            self.Particle:SetEndSize(math.random(10, 2))
            self.Particle:SetColor(150, 200, 255)
            emitter:Finish()
        end
    end

    function EFFECT:Think()
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_elecfle2_02", true)
    local EFFECT = {}
    function EFFECT:Init(data)
        local ent = data:GetOrigin()
        for i = 1, math.random(3, 7) do
            local emitter = ParticleEmitter(ent)
            self.Particle = emitter:Add("actmod/eff_particle/p_glow_01", ent)
            self.Particle:SetVelocity(Vector(0, 0, 50) + VectorRand() * 130)
            self.Particle:SetAirResistance(math.Rand(100, 400))
            self.Particle:SetDieTime(math.random(0.3, 0.5))
            self.Particle:SetStartAlpha(255)
            self.Particle:SetEndAlpha(0)
            self.Particle:SetStartSize(math.Rand(3, 5))
            self.Particle:SetEndSize(1)
            self.Particle:SetColor(math.random(100, 130), math.random(200, 230), 255)
            self.Particle:SetGravity(Vector(0, 0, -250))
            self.Particle:SetCollide(true)
            emitter:Finish()
        end
    end

    function EFFECT:Think()
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_elecfle2_03", true)
    local EFFECT = {}
    function EFFECT:Init(data)
        local ent = data:GetOrigin()
        local emitter = ParticleEmitter(ent)
        self.Particle = emitter:Add("actmod/eff_particle/p_glow_01", ent)
        self.Particle:SetDieTime(0.3)
        self.Particle:SetStartAlpha(255)
        self.Particle:SetEndAlpha(0)
        self.Particle:SetStartSize(8)
        self.Particle:SetEndSize(5)
        self.Particle:SetColor(255, 155, 255)
        emitter:Finish()
        for i = 1, math.random(20, 30) do
            local emitter = ParticleEmitter(ent)
            self.Particle = emitter:Add("actmod/eff_particle/p_glow_03", ent)
            self.Particle:SetVelocity(VectorRand() * 50)
            self.Particle:SetAirResistance(math.Rand(200, 600))
            self.Particle:SetDieTime(math.random(0.1, 0.3))
            self.Particle:SetStartAlpha(math.Rand(155, 255))
            self.Particle:SetEndAlpha(0)
            self.Particle:SetStartSize(math.random(2, 10))
            self.Particle:SetEndSize(math.random(20, 10))
            self.Particle:SetColor(255, 105, 255)
            self.Particle:SetRoll(math.Rand(-1, 1))
            self.Particle:SetGravity(Vector(0, 0, 20))
            self.Particle:SetCollide(false)
            emitter:Finish()
        end
    end

    function EFFECT:Think()
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_poki_e1", true)
    local EFFECT = {}
    function EFFECT:Init(data)
        local ent = data:GetOrigin()
        local emitter = ParticleEmitter(ent)
        self.Particle = emitter:Add("actmod/eff_particle/p_glow_01", ent)
        self.Particle:SetDieTime(0.2)
        self.Particle:SetStartAlpha(255)
        self.Particle:SetEndAlpha(0)
        self.Particle:SetStartSize(5)
        self.Particle:SetEndSize(2)
        self.Particle:SetColor(255, 255, 255)
        emitter:Finish()
    end

    function EFFECT:Think()
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_poki_e2", true)
    local EFFECT = {}
    function EFFECT:Init(data)
        local ent = data:GetOrigin()
        for i = 1, math.random(5, 10) do
            local emitter = ParticleEmitter(ent)
            self.Particle = emitter:Add("actmod/eff_particle/p_glow_03", ent)
            self.Particle:SetVelocity(VectorRand() * 50)
            self.Particle:SetAirResistance(math.Rand(200, 600))
            self.Particle:SetDieTime(math.random(0.4, 0.3))
            self.Particle:SetStartAlpha(0)
            self.Particle:SetEndAlpha(255)
            self.Particle:SetStartSize(8)
            self.Particle:SetEndSize(0)
            self.Particle:SetColor(255, 105, 255)
            self.Particle:SetRoll(math.Rand(-1, 1))
            self.Particle:SetGravity(Vector(0, 0, 20))
            self.Particle:SetCollide(false)
            emitter:Finish()
        end
    end

    function EFFECT:Think()
    end

    function EFFECT:Render()
    end

    effects.Register(EFFECT, "am_f_poki_e3", true)
end

function A_AM.ActMod:GetNameA(ply, callback)
    local steamid64
    if isstring(ply) or isnumber(ply) then
        if isnumber(ply) then
            steamid64 = tostring(ply)
        else
            steamid64 = ply
        end
    else
        steamid64 = ply:SteamID64()
    end

    local GnamE, GOnli = "nonE", "nonE"
    http.Fetch("https://steamcommunity.com/profiles/" .. steamid64 .. "?xml=1", function(body, size, headers, code)
        if size == 0 or code < 200 or code > 299 then return callback(GnamE, GOnli) end
        local url = string.match(body, "<steamID><!%[CDATA%[(.*)%]%]></steamID>")
        local urlOn = string.match(body, "<stateMessage><!%[CDATA%[(.*)%]%]></stateMessage>")
        if url and url ~= nil and url ~= "" and url ~= "nil" then GnamE = tostring(url) end
        if urlOn and urlOn ~= nil and urlOn ~= "" and urlOn ~= "nil" then GOnli = tostring(urlOn) end
        callback(GnamE, GOnli)
    end, function() callback(GnamE, GOnli) end)
end