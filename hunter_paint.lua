--[[
	HUNTER (Half-Life 2) - Plane Crazy SmallPart build - v1  (1400 SmallParts, rebuilt 1:1 from hl2_hunter_rig.glb)
	===== SHARED FIGURE DEFINITION =====
	IDENTICAL in script 1 (paint) and script 2 (run). Replace everything down to and including "-- ===== END SHARED =====" in BOTH.
	The figure is baked data: 1400 oriented plates fitted to the real mesh (skin + armor), colours sampled from the textures,
	grouped on the 48 bones of the original rig. SCALE = studs per model inch (0.4 -> ~42 studs tall).
	Model: "HL2 Hunter Rig" by NO DONT EAT ME CASEOH (Sketchfab), CC-BY-4.0.
]]
local SCALE = 0.4
local MAX_PARTS = 1400

local V3 = Vector3.new
local CFn = CFrame.new
local Ang = CFrame.Angles

-- model space: inches, Y up, the Hunter faces +Z. FRONT turns +Z into Roblox forward (-Z).
local FRONT = Ang(0, math.pi, 0)
local BONE_NAME = {
	"body_joint_01",
	"bck_clav_bone_02",
	"bck_leg1_bone_03",
	"bck_leg2_bone_04",
	"bck_leg3_jnt_05",
	"bck_foot_bone_06",
	"bck_toe_07",
	"bck_claw_08",
	"antennaBase_010",
	"antennaRaise_011",
	"antennaSpike1_012",
	"antennaSpike2_013",
	"top_stalk_bone_014",
	"top_eye_bone_015",
	"topEyeClose_016",
	"l_mandible1_017",
	"l_mandible2_018",
	"low_stalk_bone_019",
	"low_eye_bone_020",
	"bottomEyeClose_021",
	"r_mandible1_022",
	"r_mandible2_023",
	"l_clav_024",
	"l_leg1_bone_025",
	"l_leg2_bone_026",
	"l_leg3_bone_027",
	"l_foot_bone_028",
	"l_toe_029",
	"l_claw_030",
	"r_claw1_031",
	"r_claw2_032",
	"r_claw5_033",
	"r_claw4_034",
	"r_clav_bone_035",
	"r_leg1_bone_036",
	"r_leg2_bone_037",
	"r_leg3_bone_038",
	"r_foot_bone_039",
	"r_toe_040",
	"r_claw_041",
	"l_claw1_043",
	"l_claw2_044",
	"l_claw3_045",
	"l_claw4_046",
	"l_antenna1_047",
	"l_antenna2_048",
	"r_antenna1_049",
	"r_antenna2_050"
}
local BONE_PARENT = { 0, 1, 2, 3, 4, 5, 6, 7, 1, 9, 10, 10, 1, 13, 14, 1, 16, 1, 18, 19, 1, 21, 1, 23, 24, 25, 26, 27, 28, 1, 30, 31, 32, 1, 34, 35, 36, 37, 38, 39, 1, 41, 42, 43, 1, 45, 1, 47 }  -- 1-based index, 0 = root
local BONE_T = {  -- rest translation of every bone in its parent frame (inches)
	{ 1.5527, 73.9375, 14.4453 },
	{ -0.0000, -0.8204, -10.2122 },
	{ 8.1884, 0.0008, 0.0000 },
	{ 18.6183, -0.0000, -0.0000 },
	{ 17.3827, -0.0000, -0.0000 },
	{ 39.0000, -0.0018, 0.0000 },
	{ 13.2744, -2.0063, -0.3758 },
	{ 3.3469, -1.7021, 0.0855 },
	{ 10.7639, 3.6646, -9.9777 },
	{ 0.0000, 5.2128, -4.2706 },
	{ -0.3340, 14.1612, -0.5180 },
	{ 0.1749, 12.0915, -0.5503 },
	{ 0.0000, 3.7988, 7.6523 },
	{ 2.0957, 0.4321, 0.0000 },
	{ 4.9596, -0.0000, -0.0000 },
	{ 8.6586, -12.0971, 4.2890 },
	{ 13.5710, -0.0000, -0.0000 },
	{ 0.0000, -7.4492, 10.0312 },
	{ 2.0000, 0.7695, 0.0000 },
	{ 4.9596, 0.0000, -0.0000 },
	{ -8.6586, -12.0971, 4.2890 },
	{ 13.5710, 0.0000, -0.0000 },
	{ 11.8549, 0.1009, 2.9823 },
	{ 8.3224, 0.0000, -0.0000 },
	{ 19.0991, -0.0000, -0.0000 },
	{ 17.9339, 0.0000, 0.0000 },
	{ 37.0000, 0.0000, 0.0000 },
	{ 13.9375, 1.0879, 0.4021 },
	{ 2.8831, 1.6989, 0.0246 },
	{ -3.0344, -12.5286, 11.7759 },
	{ 4.1476, -0.0000, 0.0000 },
	{ 11.6534, 0.0000, 0.0000 },
	{ 12.4450, 0.0000, 0.0000 },
	{ -11.8549, 0.1009, 2.9823 },
	{ 8.3224, -0.0000, 0.0000 },
	{ 19.0991, -0.0000, 0.0000 },
	{ 17.9339, 0.0000, 0.0000 },
	{ 37.0625, -0.0000, -0.0000 },
	{ 12.2671, 1.6172, 0.0335 },
	{ 4.9124, 1.4933, 0.0460 },
	{ 3.0344, -12.5286, 11.7759 },
	{ 4.1476, -0.0000, -0.0000 },
	{ 11.6534, 0.0000, -0.0000 },
	{ 12.4450, 0.0000, 0.0000 },
	{ 1.2687, -14.1289, 8.6198 },
	{ 6.9240, 0.0000, -0.0000 },
	{ -1.2917, -14.1289, 8.6198 },
	{ 6.9240, 0.0000, 0.0000 }
}
local COUNTS = { 264, 2, 76, 51, 69, 33, 8, 12, 14, 45, 2, 2, 48, 41, 3, 18, 5, 36, 40, 3, 19, 5, 17, 65, 49, 68, 33, 7, 13, 5, 15, 13, 9, 12, 68, 51, 68, 28, 15, 12, 6, 14, 13, 9, 6, 2, 4, 2 }
local PAL = { "33322e", "535f5d", "3a403a", "647070", "6d7c7b", "596968", "3f3f3f", "555046", "191919", "5e6e6c", "2e2d26", "676557", "3a3a33", "414235", "697877", "363c3a", "333933", "4f5b61", "5c574d", "4b5b56", "3a362e", "3f4a4b", "849392", "4f5a5a", "4a4a41", "464a36", "41403a", "4b5656", "566161", "333633", "526261", "333426", "514b46", "46453f", "464646", "3a3c3a", "434b4f", "676155", "51523f", "635d51", "353936", "58574b", "40443f", "36362e", "636051", "343329", "3a3e36", "3e4344", "3a3f3f", "555246", "3d3f2e", "46453a", "2e3333", "46423d", "6d6c5c", "33342e", "333433", "4a463f", "464636", "526161", "353633", "3a3a3a", "363e3a", "4a4a3a", "525c5c", "605c51", "6b6656", "647372", "41443a", "333936", "566264", "2e2c2e", "33393a", "363c36", "3d3a2e", "36372e", "515149", "687776", "363a36", "4a4641", "3f454b", "292821", "2e332e", "465152", "363932", "3a3a2e", "3f4035", "333333", "3b4043", "35332e", "626055", "333636", "333434", "6b7979", "3f3929", "525f61", "616b6b", "332f2e", "3a3930", "2a242a", "5c5c44", "4d5246", "4a4b4a", "363f3f", "677573", "3a4141", "3f4b46", "484741", "4d4b46", "36342e", "525440", "4a4b46", "3f403a", "3a3b36", "3f443a", "4b5759", "5b6162", "4b595a", "3a413a", "3a3933", "5c6766", "514b41", "3a3f3a", "35393a", "4d4d41", "5b6969", "363a3a", "4b5255", "41413e", "414640", "464633", "3f4648", "343432", "515046", "605c4d", "6d7b7a", "666258", "3f4946", "3f4547", "343434", "575746", "676151", "4d4b41", "4c4b3a", "41412e", "514d3a", "3d3c33", "3f3f3a", "5a5751", "191b19", "515146", "586564", "5c6465", "514d46", "585c46", "6d685c", "4d4d46", "364041", "4d4b44", "514d3f", "363938", "4f5c5c", "3b4346", "5c5a51", "3a403f", "3f3f3c", "5c5b4d", "55554b", "5c6a6a", "3f4b4f", "3a3a30", "36392e", "3a3c33", "677575", "34342e", "3f403f", "464b46", "44403a", "585346", "4f5f61", "434f4f", "464641", "515141", "657473", "606f6e", "555146", "4a4a36", "556564", "464a3a", "3a3c2e", "363934", "2e2f2e", "2e3636", "2e2821", "3f474b", "46504f", "333735", "33362e", "363635", "464a3f" }
local DATA = table.concat({
"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",
"hUe8fF8PJdrnhAchUgpey6JJIZXfAe",
"gCf+evuiJLRayA8lkgwf+sTJLWn6BhhEgYhjkkJO2G+B2izgjeXpcJMCPCAdhoexfTtrJJ9GuBxeLgZg5iWLSSvYAej0edgMnaJKmV1BTkCecfLmaLE85PB1hmhlf0kiJEOoGBni/fwhYoiJMd06AQgwfkhSmhJM2pGC2j+f8hLrrJOplAAoeihMf6jcJElMFAdkCg7f3poJCxyDAPlBgXg8vgJMJe7BZg0gwebnlJNGS6Adj7g1e7ohJMjvEBLivfyeUucJMV6/Arf0fHhRnhJNt47AegtfWe6jcJN9XGAMiaelgGxhJRrnZBxl9gGgfkhJD0nWAed+gigJbYJQe7SCplrgUe9qcQA6gPB3fdhhg2jdJS3k6A0gxhLhalgJMxM9AweSgvfYcbJJbAfAohje8hBomJG+ooCRgShtgLneJDh0BAPkTfChAqrKF+SpAulFgwfJtsJVYZXAre+f3hPncJNxrEAejDhHf2mpJKjphBpkxfcedujKMJtFAAjzfFeqsjJUHTMCri4hCe2mhJfd03BUfEgme5nhJCBrMA8gDgShYqnJLWNLCWgZecg5unJNaspAViUe8hDomJHGglBUf1e3e4fcJNV7ABffygzeoohJM1+xAdhygUeSldJC2A/DFhQfvekvhJNlE8BUjGezfrvhJN8xxAzgleFgKrjJM8ltABeihFgpjbJSrevAdgbhsforfJLr5HA+i1gnhNpjJMRa1B7jTfGg8smMeVXyA/iZhQgnqlJTv1dAPk6g2gSvlJYezbAAhzhFehnfJMW1CBUhoefgNoeJRPhkANf3hMhVjbJKtdJAdj6gHeZuoJPqQ8DFfWhjf7ljJCYmUA4hQhefAmiJV05wB+iifGewwrJBGbiBUh7f7heqhJHWC7AohShlgtpjJTDlbB6fBgwhIplJMuDOBEh3hBhSonJKZevB6lMfihDslJMR+2A3lJgSekvnJNuU/AtfOfae3fYJB9/AAeeif7fChTJNiGxAegUhZe4hhJHK2eAdgYhog6jbJUns6B6iNhTfOjjJLXngAPe0hOfReeJeO0uAAmCgNfnhZJKib8AeeCgSfedQJCJChAcjsg2gutgJUPdJDGfghYfFkhJJTXIAAgZeXfUohJNpbZAB",
"hpeUgmpZLB1QrCkhsg/frqrJGWmKBFlaf2e0kbJCKiyANh7eIfppaJRPHeAIiWfMehqeJBiFLAdkafthBrnJMiE7ArijgogkqhJIpOrC/gWgYf7nUJOovvAehqeyewtfJBOTVCCkeeWgFleJB4wUBIkcgtfwpnJKbbmA6jQe4emmhJFB7UBOjGgge4okJOrAuAojveNgBjcJeXaUBOlJfJe6fcJL5PQBFjyekgvohJGCGlBbkQgdgqsjJGFbiAAlmfUgqqnLMSYwDGhRfzemujJLiS4AtiRfuhAulJBmJEB7g8gIgumhON1VUC/j9gee2kmJOrIrBUmHfFgGcVJB4giAek4gZe6ieJNPq/BKilg9fpljJG/afAPiyf2eeojJCt66Btg8gkfzybJC8MqBhlFgRgyjfPA2TeCsineYfEqgKDJ/tBxiVexg0mdKBN4eB7lSengGhfJB4eeAdjEetg7kdJAliyB+k2g6frjKJJ6v4Aek9elfZmaJLgrNAohafVg9rkJAJ85A0jyeXfJpfJEKPsBJjlg2fwlkJflvDAdi5eNgBphJJXPtBOiKgYewseJTFWMAAhaghe4qdJF2IeC/lsfRfJeSJZVz2Aokue1gwsjJDhwrAdhugygarqJGNzfC/l7fEfigWJFqLmAejVgsgfrkJCCbfC/kofzekjjJIlzHAMjxfsedmlJDF+8AojXfShEpcJMGA9CkkSe7ewljJMRPOAPjRgAg/mbJEaDKA8gggFe8lbOdu+KAe",
"m0g7fyraJT79DAjjNfMe3peJLdhCDElQgTgdtpJP1hFACpvfzfzxbJfp43AzqxgHgCtpJOFbFBMhpfbg3njJNdc+CsgofmgzpiJMl/IBUjaguffliLF2UpB6mrgjfSxfJDqIvBIjcgBe/kgJO2syACoSf/f+0RJep+/Brg0gofMeZJGWW1AeiEe/e5mjJLtXAA4izgEgekeJKJa3APlUfdgTklJWA7XCBgufte6vfJKiW1CPitfxe1icJMOq+B6j6e3fgqhJRfHhAPkff/gpnnJPRpFAPqQgDfVxZJMd4/AYopf+ffpXJULbAAahveqgtjfJddNtAMmMgIfMrjJLxvGCkg5gcgbpnMAOlRAef/e7gQpXMI69iAeimfWg4pkJNNTFB6lTgWfIphKG2U3APrmgBfXtjKLqS/A5ojggf+oiJNhbBC1pJgdfergMNKi/AzifggfNpgJKejKBwqQggflxVKe944Bsixg9fzkYJTz4/AdmLfxgKhaJLrU1BvkcgpfQpbJL6y6APkag3f6rmMTTlRDErEfjfxtgJMD5KBPm5f3f3qhJKLzJAjndgAfcpZJTjZEBwhEeegBpaJMj1IBSg9g8fwgWJZfjlAehxgzf7reJCcuPBwgIe+faloJLg8yCKn+gnfcrfKMGvCBwj7fCgkjYJIjJPAPg9fHe9qdJMNS2AdjIejf9jcJEBmDAPkOgFe9jbJLGy/A+psgWf+piJNFbBAhiXgmgRhZJLNi4Aokcfhe6wcJLNbEAohagdfFpYJTo4oBkkqfNgWngJeth1APjOe4gsidJHigfBIhvf2e1ilJMmjDBWrvgEf8pkLME+6AhizenfSraJUDcyA+igewgvgeJVpVzBOjmfmgwqmJJFU4AokvfIfdhjJTvsuB+g+e0gokeJdpVSAdiMeYf8pjJR/tXBWmagbgQsmJMhm6B6ltfifkqhJTHm7CkjmgpgNrjJOBXMAPhugIgjmhJN1Y8BUlmg6fupiJDZuDAPnjgggDojKLJi4AihUejfVmcJUfXFBS",
"kSgFfMlaJJWbRA2gZgPftkeJSz7BA1jXgYgQmfJLU+9AngzfQfhqWJULlGCAisf7fBfcJLma9CGisfAgOljJetlECjhPgOgFkaJL5BHBMhgfsgXneJLxtGCIiif0gcniJP13MBBj4fKfFreJL9ZDC5gsfSgElXJe528CxgZfufOoaJDZ5EBPlGf/gMifJEJbPCyjue0gNrhJL7jDCjitfUfDoZJDd3UAxkbghf+igKYuvLCGi7giffedJeZDwCIhcgbfigaJL7q4AgjsghfgjeJF2sWBCkyfkfNjXJKh9NApine6ffpaJUXjLCOhtfKgDjgJMDfHCFhmfXfRnfJDl5dCFkHgHgdfdJFBzOBBjjfxe/kfJNiY/BaiOghf5ieJUTmyBaiCgNfMmdJJClJAHlLgHflgfKOrXECmkafVgcreJLOO3AnjafggkjgJMt5ABChGgCfOlaJNik1COgff0gLlgJNprIBsjxetfhsZJTznHAg",
"gIfLf/mcOZLlVBGh1fNgeoeKNpvFAeiUfCfogZKLFh8AViRfDgNkcPMmb7Akg5fPgasYJEeG0Aeh8fhf4lfJQ40bAVg5fKfcoTJMVW8Aeh1fQfgojUNWq/Ae",
"g3g3gAqdJU33GBZf6g3gcxeJDds8AXfWhHf9jOJE94zA7iQgMf+xaJNcIxB8fbhKf0iNJE+FKBTfJhGgVfZJSfqrAefOhGfecZKKDs0AXhLgpf7siMEVj7Btgbg2ffpYJECRAAXhvgggKvhLNoJAAaf4hNf3nkJREojA7fig5fUgeJOiNHB/",
"gpgYfefeJbUXqCugOgxgEebJCWBwBUfTfyf0hgJScbrDGgEfXgAhdJJ/hRCTfUgYfhiiJD8YrBUfrgLfCgYJJmWwAogkf9gNicJF04uAofmgogHjXJT/aQAognfqfkhfJSrkXAAgUgHfCicJP2ZPBZf/g1fVgfJMnY7A8ftfygYkcJdFmrCTgIgTgecaJLxe4BxfyfdfWgeJVXGwA8",
"fmdNgcpYJSK4JAGgQkbgZkdJVVsKCLfge9gGoYJOsqRAGgMkhfbodJTKMFCLfXhHgElkJQs5lBXgYgEgcpaKA05RA4ghhefsokJR2yTBXfmi3gZoeJSBhnBXgRe+gclbJVhWIB6f3fTfooYJHto4B6ftkygUkhJSqybCLgIcugPojWeqXOClgMjZgkueJPpq3BXf/cjf8xcVHpe2CvgghLgapeJI2ufBXgfibfnmeJdlCIBXfveVgdpeKSSgQAGf+cUgJmUaOuPCBxfodSf5pbJAxDaAGf0iVfZodJbWQBBXgnj6f6peJREtpBXgMjffXnfJchoJBXfzhQfbneJPxq1BXgTdgf3ldKSayHAGfgkOfmnbJHJEiBcfwhxgmleJPmRKA4fyeKfyoeLbCeGAGgngdgDjdJRfYSBXgMgafeleJTmgFBXffj4gTmeJdo+JCEgZiOgZmeLBVJSBXgcd8gUpWJAs7kAGfggNfvmbJIqibBXgWlAf5giMeUY/BxgIdhgnvYJUpsBAGgafgf4gYJSDCJA9fXiIf+ldJREppBXf1gqgqneJPaPMA4gIcpgTiYSN3onA9figHgYjbJSc3yA4ffjJfmodJIm0jBXgli8gGieJJPCUBXfylHfwfcKfCPiAof4ffgklYJTaQIAjgYegf1gXJdtGHAG",
"f+gfgDaEJRbUSBngBgegEgIJI3IaCd",
"gDgdgDdKJHpUsBngBhcgCkGJP5/BBI",
"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",
"hufygKxKJEx8yAeghf0gIqIJUTJNAe",
"haf8gNySJECA+Aehaf2f/xRJD6FtAbhsgGf/dQJfB89A7g8f/gBaVPE2IxAe",
"gif0gDtJJM63CAehxf0f+vJJLKM8Ae"
})

local ALPHA = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local MAP = {}
for i = 1, 64 do MAP[ALPHA:byte(i)] = i - 1 end
-- smallest-three quaternion: 2 bits (dropped component) + 3 components of B bits each
local function unpackQ(qb, B)
	local S = 2 ^ B
	local m = math.floor(qb / S ^ 3) % 4
	local k = S - 1
	local c = {
		(math.floor(qb / S ^ 2) % S) / k * 1.4144 - 0.7072,
		(math.floor(qb / S) % S) / k * 1.4144 - 0.7072,
		(qb % S) / k * 1.4144 - 0.7072,
	}
	local qq, ii = { 0, 0, 0, 0 }, 1
	for t = 1, 4 do
		if t - 1 ~= m then qq[t] = c[ii] ii = ii + 1 end
	end
	local s2 = qq[1] ^ 2 + qq[2] ^ 2 + qq[3] ^ 2 + qq[4] ^ 2
	qq[m + 1] = math.sqrt(math.max(0, 1 - s2))
	return qq
end
local function newReader(str)
	local pos = 1
	local function rd(n)
		local v = 0
		for _ = 1, n do v = v * 64 + MAP[str:byte(pos)] pos = pos + 1 end
		return v
	end
	local function ch() local c = str:sub(pos, pos) pos = pos + 1 return c end
	return rd, ch
end
local function clampN(v, a, b) return math.max(a, math.min(b, v)) end

local palc = {}
for i, h in ipairs(PAL) do
	local n = tonumber(h, 16)
	palc[i - 1] = { math.floor(n / 65536), math.floor(n / 256) % 256, n % 256 }
end

-- BOXES[i] = { bone = index, cf = bone-local CFrame (studs), size = Vector3 (studs), color ... }
local BOXES = {}
do
	local rd = newReader(DATA)
	for bi = 1, #BONE_NAME do
		for _ = 1, COUNTS[bi] do
			local x, y, z = (rd(2) - 2048) * 0.05, (rd(2) - 2048) * 0.05, (rd(2) - 2048) * 0.05
			local sx, sy, sz = rd(1) * 0.1, rd(1) * 0.1, rd(1) * 0.1
			local q = unpackQ(rd(4), 7)
			local c = palc[rd(2)]
			BOXES[#BOXES + 1] = {
				bone = bi,
				cf = CFn(x * SCALE, y * SCALE, z * SCALE, q[1], q[2], q[3], q[4]),
				size = V3(clampN(sx * SCALE, 0.1, 2.5), clampN(sy * SCALE, 0.1, 2.5), clampN(sz * SCALE, 0.1, 2.5)),
				r = c[1], g = c[2], b = c[3],
			}
		end
	end
end
local function gridOf(studs) return math.clamp(studs / 2.5, 0.04, 1) end
local function q100(v) return math.floor(v * 100 + 0.5) end
for _, b in ipairs(BOXES) do
	b.gx, b.gy, b.gz = gridOf(b.size.X), gridOf(b.size.Y), gridOf(b.size.Z)
	b.color = Color3.fromRGB(b.r, b.g, b.b)
	b.key = q100(b.gx) .. "," .. q100(b.gy) .. "," .. q100(b.gz) .. "|" .. b.r .. "," .. b.g .. "," .. b.b
end
print(("[Hunter] SCALE %.2f -> %d SmallParts needed (cap %d)"):format(SCALE, #BOXES, MAX_PARTS))
assert(#BOXES <= MAX_PARTS, "[Hunter] too many parts")
-- ===== END SHARED =====

-- SCRIPT 1 (paint + sizes): run this FIRST on the UNSPAWNED plot (works on PC and mobile executors).
-- Paste this BELOW the shared block (it needs BOXES). Then spawn the plane and run script 2.
----------------------------------------------------------------------
----------------------------------------------------------------------
if getgenv().HunterRunning then warn("[Hunter] already running - rejoin to reset") return end
getgenv().HunterRunning = true

local function main()
	local Players = game:GetService("Players")
	local RS = game:GetService("ReplicatedStorage")
	local lp = Players.LocalPlayer
	local Remotes = RS:WaitForChild("Remotes")
	local UpdateValue = Remotes:WaitForChild("UpdateValue")

	local DO_PAINT = true
	local DO_SIZE = true
	local TEST_LIMIT = nil          -- number = only handle the first N parts (quick test), nil = everything
	local PAINT_BATCH = 31          -- same as the working script
	local MAX_RETRIES, RETRY_DELAY, CALL_TIMEOUT = 4, 0.15, 2
	local REPORT_WAIT = 45          -- seconds to wait for sizes to land before reporting (no resending)

	local plotRoot = workspace:FindFirstChild("PIayerAircraft") -- capital I
	local plot = plotRoot and plotRoot:FindFirstChild(lp.Name)
	assert(plot, "[Hunter] unspawned plot not found")

	local paintRemote
	for _, v in ipairs(Remotes:GetDescendants()) do
		if v.Name == "paintRemote" then paintRemote = v.Parent break end
	end
	assert(paintRemote, "[Hunter] paintRemote not found")

	-- status window
	local guiParent = (gethui and gethui()) or lp:WaitForChild("PlayerGui")
	pcall(function() local old = guiParent:FindFirstChild("HunterGen") if old then old:Destroy() end end)
	local gui = Instance.new("ScreenGui")
	gui.Name = "HunterGen"
	gui.ResetOnSpawn = false
	pcall(function() gui.Parent = guiParent end)
	-- mobile friendly: sits below the notch / top bar, scales with the screen, bigger text on touch devices
	local UIS = game:GetService("UserInputService")
	local isTouch = UIS.TouchEnabled and not UIS.KeyboardEnabled
	gui.IgnoreGuiInset = false
	pcall(function() gui.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets end)
	local lbl = Instance.new("TextLabel")
	lbl.AnchorPoint = Vector2.new(0.5, 0)
	lbl.Size = UDim2.new(0.92, 0, 0, isTouch and 96 or 80)
	lbl.Position = UDim2.new(0.5, 0, 0, 12)
	lbl.BackgroundColor3 = Color3.new(0, 0, 0)
	lbl.BackgroundTransparency = 0.3
	lbl.TextColor3 = Color3.new(1, 1, 1)
	lbl.Font = Enum.Font.Code
	lbl.TextSize = isTouch and 17 or 14
	lbl.TextWrapped = true
	lbl.Parent = gui
	local lim = Instance.new("UISizeConstraint")
	lim.MaxSize = Vector2.new(520, 140)
	lim.Parent = lbl
	local pad = Instance.new("UIPadding")
	pad.PaddingLeft, pad.PaddingRight = UDim.new(0, 8), UDim.new(0, 8)
	pad.Parent = lbl
	local function status(t) lbl.Text = t print("[Hunter] " .. t) end

	-- collect plot SmallParts (same order as before)
	local smallParts = {}
	for _, v in ipairs(plot:GetDescendants()) do
		if v.Name == "SmallPart" and v:IsA("Model") and v:FindFirstChild("SPart") then
			table.insert(smallParts, { model = v, part = v.SPart, position = v.SPart.Position })
		end
	end
	table.sort(smallParts, function(a, b)
		local ap, bp = a.position, b.position
		if math.abs(ap.Y - bp.Y) > 0.01 then return ap.Y < bp.Y end
		if math.abs(ap.Z - bp.Z) > 0.01 then return ap.Z > bp.Z end
		return ap.X < bp.X
	end)

	local count = math.min(#BOXES, #smallParts)
	if TEST_LIMIT then count = math.min(count, TEST_LIMIT) end
	if #BOXES > #smallParts then
		warn(("Need %d SmallParts, plot only has %d - %d boxes will be missing!"):format(#BOXES, #smallParts, #BOXES - #smallParts))
	end
	status(("Found %d SmallParts, need %d, using %d"):format(#smallParts, #BOXES, count))
	assert(count > 0, "[Hunter] no SmallParts on the plot")

	local function callWithTimeout(fn)
		local done, ok, res = false, false, nil
		task.spawn(function() ok, res = pcall(fn) done = true end)
		local t = tick()
		while not done and tick() - t < CALL_TIMEOUT do task.wait() end
		if not done then return false end
		return ok, res
	end

	------------------------------------------------------------------
	-- STEP 1: PAINT (parallel batches, like the working script)
	------------------------------------------------------------------
	local paintFail = 0
	if DO_PAINT then
		local jobs = {}
		for i = 1, count do
			jobs[i] = { part = smallParts[i].part, color = BOXES[i].color }
		end
		local function paintOne(job)
			if job.part.Color == job.color then return true end
			for _ = 1, MAX_RETRIES do
				local ok, r = callWithTimeout(function()
					return paintRemote:InvokeServer(job.part, job.color, nil)
				end)
				if ok and r then return true end
				task.wait(RETRY_DELAY)
			end
			return false
		end

		local painted, nextIndex = 0, 1
		while nextIndex <= #jobs do
			local n = math.min(PAINT_BATCH, #jobs - nextIndex + 1)
			local finished = 0
			for k = 0, n - 1 do
				local job = jobs[nextIndex + k]
				task.spawn(function()
					if not paintOne(job) then paintFail = paintFail + 1 end
					finished = finished + 1
				end)
			end
			while finished < n do task.wait() end
			painted = painted + n
			nextIndex = nextIndex + n
			status(("Colours %d/%d (%d failed)"):format(painted, #jobs, paintFail))
		end
	end

	------------------------------------------------------------------
	-- STEP 2: SIZES (one burst, no pacing, no resend)
	------------------------------------------------------------------
	local sizeMiss = 0
	if DO_SIZE then
		local objs = {}
		local spawned, finished = 0, 0
		status("Sending sizes...")
		for i = 1, count do
			local box, model = BOXES[i], smallParts[i].model
			spawned = spawned + 1
			task.spawn(function()
				local c = model:WaitForChild("Configuration", 3)
				local o = c and {
					c:WaitForChild("Size X", 3),
					c:WaitForChild("Size Y", 3),
					c:WaitForChild("Size Z", 3),
				}
				objs[i] = o
				if o then
					local v = { box.gx, box.gy, box.gz }
					for k = 1, 3 do
						if o[k] and math.abs((tonumber(o[k].Value) or -1) - v[k]) > 0.006 then
							pcall(function() UpdateValue:FireServer(v[k], o[k]) end)
						end
					end
				end
				finished = finished + 1
			end)
			if i % 100 == 0 then task.wait() end
		end
		while finished < spawned do
			status(("Sizes sent %d/%d"):format(finished, spawned))
			task.wait(0.2)
		end

		-- REPORT ONLY: give the server time to catch up, count what landed, never resend
		local function countMissing()
			local miss = 0
			for i = 1, count do
				local o, box = objs[i], BOXES[i]
				local want = { box.gx, box.gy, box.gz }
				local ok = o and o[1] and o[2] and o[3]
				if ok then
					for k = 1, 3 do
						if math.abs((tonumber(o[k].Value) or -1) - want[k]) > 0.006 then ok = false break end
					end
				end
				if not ok then miss = miss + 1 end
				if i % 400 == 0 then task.wait() end
			end
			return miss
		end
		local t0, best, stuck = tick(), math.huge, 0
		while tick() - t0 < REPORT_WAIT do
			task.wait(3)
			sizeMiss = countMissing()
			status(("Server applying sizes... %d of %d still missing"):format(sizeMiss, count))
			if sizeMiss == 0 then break end
			if sizeMiss < best then best = sizeMiss stuck = 0 else stuck = stuck + 1 end
			if stuck >= 4 then break end
		end
	end

	status(("DONE. paint fails: %d, sizes still missing: %d. If any are missing just run again (done parts are skipped). Then spawn the plane and run script 2."):format(paintFail, sizeMiss))
	task.delay(15, function() gui:Destroy() end)
end

local ok, err = pcall(main)
getgenv().HunterRunning = false
if not ok then warn("[Hunter] error: " .. tostring(err)) end