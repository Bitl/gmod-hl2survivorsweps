SWEP.Category 				= "Half-Life 2 Survivor Ver2.0"
SWEP.PrintName				= "SMG1 Skin 1 (Red)"			
SWEP.Author					= "Taito, Valve, and Bitl"
SWEP.Instructions			= ""
SWEP.Spawnable 				= true
SWEP.AdminOnly 				= false
SWEP.Primary.ClipSize		= 45
SWEP.Primary.DefaultClip	= 45
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "SMG1_Grenade"
SWEP.Weight					= 3
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Slot					= 2
SWEP.SlotPos				= 3
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= true
SWEP.ViewModel				= "models/weapons/v_smg1_r_s1.mdl"
SWEP.WorldModel				= "models/weapons/w_smg1_s1.mdl"

function SWEP:Initialize()

	self:SetWeaponHoldType( "smg" )

end

function SWEP:PrimaryAttack()

	-- Make sure we can shoot first
	if (  !self:CanPrimaryAttack() ) then return end

	-- Play shoot sound
	self.Weapon:EmitSound( "Weapon_SMG1.Single" )
	
	-- Shoot 9 bullets, 150 damage, 0.75 aimcone
	self:ShootBullet( 6, 1, 0.06 )
	
	-- Remove 1 bullet from our clip
	self:TakePrimaryAmmo( 1 )
	
	-- Punch the player's view
	self.Owner:ViewPunch( Angle( -1, 0, 0 ) )
	
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.085 )

end