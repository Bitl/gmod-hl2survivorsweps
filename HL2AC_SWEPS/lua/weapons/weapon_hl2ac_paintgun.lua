SWEP.Category 				= "Half-Life 2 Survivor Ver2.0"
SWEP.PrintName				= "Paintgun"			
SWEP.Author					= "Taito, Valve, and Bitl"
SWEP.Instructions			= ""
SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false
SWEP.Primary.Sound			= Sound( "weapons/hl2ac/paintgun_fire.wav" )
SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 12
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Buckshot"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "None"
SWEP.Weight					= 3
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Slot					= 3
SWEP.SlotPos				= 4
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= true
SWEP.ViewModel				= "models/weapons/v_paint_gun.mdl"
SWEP.WorldModel				= "models/weapons/w_paint_gun.mdl"
SWEP.Reloading				= false
SWEP.ReloadSound			= Sound( "weapons/hl2ac/paintgun_reload.wav" )

function SWEP:Initialize()

	self:SetWeaponHoldType( "shotgun" )

end

function SWEP:PrimaryAttack()

	-- Make sure we can shoot first
	if (  !self:CanPrimaryAttack() ) then return end

	-- Play shoot sound
	self.Weapon:EmitSound(self.Primary.Sound)
	
	-- Shoot 9 bullets, 150 damage, 0.75 aimcone
	self:ShootBullet( 9, 6, 0.06 )
	
	-- Remove 1 bullet from our clip
	self:TakePrimaryAmmo( 1 )
	
	-- Punch the player's view
	self.Owner:ViewPunch( Angle( -1, 0, 0 ) )
	
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.75 )

end

--TODO: Fix this. -Bitl

--function SWEP:SecondaryAttack()

	-- Make sure we can shoot first
	--if (  !self:CanSecondaryAttack() ) then return end

	-- Play shoot sound
	--self.Weapon:EmitSound(self.Primary.Sound)
	
	-- Shoot 9 bullets, 150 damage, 0.75 aimcone
	--self:ShootBullet( 9, 6, 0.06 )

	--self:TakePrimaryAmmo( 2 )
	
	-- Punch the player's view
	--self.Owner:ViewPunch( Angle( -1, 0, 0 ) )
	
	--self.Weapon:SetNextSecondaryFire( CurTime() + 0.75 )

--end

--Had to copy the following code from the halo sweps.
function SWEP:Reload()
	if SERVER then
			if !(self.Owner:GetActiveWeapon():GetClass() == "weapon_hl2ac_paintgun") then return end
			if self.Reloading || self.Owner:GetAmmoCount( "Buckshot" ) == 0 then return end
			if self.Weapon:Clip1() < self.Primary.ClipSize then
			self.Weapon:SendWeaponAnim( ACT_SHOTGUN_RELOAD_START )
			self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
			self.Weapon:SetClip1(  self.Weapon:Clip1() + 1 )
			self.Weapon:SetNextSecondaryFire(CurTime() + 1)
			self.Weapon:SetNextPrimaryFire(CurTime() + 1)
			self.Weapon:EmitSound(self.ReloadSound)
			--self.Owner:SetAnimation( ACT_HL2MP_GESTURE_RELOAD_SHOTGUN )
			self.Reloading = true

			local PerformReload = function()
				if !self.Reloading then 
					timer.Destroy( "Reload_" .. self.Weapon:EntIndex() )
					return
				end
				local Ammo = self.Weapon:Clip1( )
				
				if Ammo >= self.Primary.ClipSize || self.Owner:GetAmmoCount( "Buckshot" ) == 0 then
					self.Reloading = false
					timer.Destroy( "Reload_" .. self.Weapon:EntIndex() )
					self.Weapon:SendWeaponAnim( ACT_SHOTGUN_PUMP )
					self.Weapon:SetNextSecondaryFire(CurTime() + 0.35)
					self.Weapon:SetNextPrimaryFire(CurTime() + 0.35)
				else
					self.Reloading = true
					self.Weapon:SendWeaponAnim( ACT_VM_RELOAD )
					if self.Owner:GetAmmoCount( "Buckshot" ) <= 0 then return end
					self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
					self.Weapon:SetClip1(  self.Weapon:Clip1() + 1 )
					self.Weapon:SetNextSecondaryFire( CurTime() + 0.2 )
					self.Weapon:SetNextPrimaryFire( CurTime() + 0.2 )
					self.Weapon:EmitSound(self.ReloadSound)
					--self.Owner:SetAnimation( ACT_HL2MP_GESTURE_RELOAD_SHOTGUN )
				end
			end
			timer.Create( "Reload_" .. self.Weapon:EntIndex(), 0.45, 17- self.Weapon:Clip1(), PerformReload)
		end
	end
end

function SWEP:Holster()
	if self.Reloading then
		self.Reloading = false
		timer.Destroy( "Reload_" .. self.Weapon:EntIndex() )
	end
	return true
end