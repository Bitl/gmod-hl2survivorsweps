SWEP.Category 				= "Half-Life 2 Survivor Ver2.0"
SWEP.PrintName				= "Pistol with Silencer (Red)"			
SWEP.Author					= "Taito, Valve, and Bitl"
SWEP.Instructions			= ""
SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false
SWEP.Primary.Sound			= Sound( "weapons/hl2ac/gun_silencer.wav" )
SWEP.Primary.ClipSize		= 18
SWEP.Primary.DefaultClip	= 36
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "Pistol"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "None"
SWEP.Weight					= 3
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Slot					= 1
SWEP.SlotPos				= 4
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= true
SWEP.ViewModel				= "models/weapons/v_silencer_pistol_r.mdl"
SWEP.WorldModel				= "models/weapons/w_silencer_pistol.mdl"

function SWEP:Initialize()

	self:SetWeaponHoldType( "pistol" )

end

function SWEP:PrimaryAttack()

	-- Make sure we can shoot first
	if (  !self:CanPrimaryAttack() ) then return end

	-- Play shoot sound
	self.Weapon:EmitSound(self.Primary.Sound)
	
	-- Shoot 9 bullets, 150 damage, 0.75 aimcone
	self:ShootBullet( 10, 1, 0.01 )
	
	-- Remove 1 bullet from our clip
	self:TakePrimaryAmmo( 1 )
	
	-- Punch the player's view
	self.Owner:ViewPunch( Angle( -1, 0, 0 ) )
	
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.45 )

end