SWEP.Category 				= "Half-Life 2 Survivor Ver2.0"
SWEP.PrintName				= "Sniper Rifle (Blue)"			
SWEP.Author					= "Taito, Valve, and Bitl"
SWEP.Instructions			= ""
SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false
SWEP.Primary.Sound			= Sound( "weapons/hl2ac/rifle_shot.wav" )
SWEP.Primary.ClipSize		= 2
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "None"
SWEP.Weight					= 3
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Slot					= 2
SWEP.SlotPos				= 4
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= true
SWEP.ViewModel				= "models/weapons/v_sniperAC_b.mdl"
SWEP.WorldModel				= "models/weapons/w_sniper_new.mdl"
SWEP.Zoom					= 0
SWEP.ZoomSound				= Sound( "weapons/hl2ac/scope.wav" )
SWEP.Reloading				= false

function SWEP:Initialize()

	self:SetWeaponHoldType( "ar2" )

end

function SWEP:PrimaryAttack()

	-- Make sure we can shoot first
	if (  !self:CanPrimaryAttack() ) then return end

	-- Play shoot sound
	self.Weapon:EmitSound(self.Primary.Sound)
	
	-- Shoot 9 bullets, 150 damage, 0.75 aimcone
	self:ShootBullet( 55, 1, 0.01 )
	
	-- Remove 1 bullet from our clip
	self:TakePrimaryAmmo( 1 )
	
	-- Punch the player's view
	self.Owner:ViewPunch( Angle( -1, 0, 0 ) )
	
	self.Weapon:SetNextPrimaryFire( CurTime() + 1.30 )

end

function SWEP:SecondaryAttack()
	
		if(self.Zoom == 0) then

				if(SERVER) then
					self.Owner:SetFOV( 45, 0 )
				end 

				self.Zoom = 1
				self.Weapon:EmitSound(self.ZoomSound)

		else if(self.Zoom == 1) then

				if(SERVER) then
					self.Owner:SetFOV( 25, 0 )
				end 

				self.Zoom = 2
				self.Weapon:EmitSound(self.ZoomSound)

		else

				if(SERVER) then
					self.Owner:SetFOV( 0, 0 )
				end     

				self.Zoom = 0
				self.Weapon:EmitSound(self.ZoomSound)

		end
	end
end

function SWEP:Reload()
	if self.Owner:GetActiveWeapon():Clip1() == 12 then return end
	if self.Reloading || self.Owner:GetAmmoCount( "smg1" ) == 0 then return end
	if self.Weapon:Clip1() < 12 then
		if(SERVER) then 
			self.Owner:SetFOV( 0, 0 )
		end
		self.Zoom = 0
		self.Weapon:DefaultReload(ACT_VM_RELOAD)
	end
	return true
end

function SWEP:Holster() 
	if(SERVER) then 
		self.Owner:SetFOV( 0, 0 )
	end
	self.Zoom = 0
	return true
end