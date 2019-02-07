-- Use Include 'prosody-ldap.cfg.lua' from prosody.cfg.lua to include this file
authentication = 'ldap2' -- Indicate that we want to use LDAP for authentication
--storage        = 'ldap' -- Indicate that we want to use LDAP for roster/vcard storage
storage = {
        roster = "sql";
        vcard = "sql";
        archive2 = "sql";
        muc_log = "sql";
}

ldap = {
    hostname      = '{{LDAP_HOST}}',          -- LDAP server location
    bind_dn       = '{{LDAP_DN}}',            -- Bind DN for LDAP authentication (optional if anonymous bind is supported)
    bind_password = '{{LDAP_PASS}}',           -- Bind password (optional if anonymous bind is supported)

    user = {
      basedn        = '{{LDAP_USER_BASE}}',                      -- The base DN where user records can be found
      filter        = '(&(objectClass=person)(!(uid=seven)))', -- Filter expression to find user records under basedn
      usernamefield = '{{LDAP_USER_FIELD}}',                    -- The field that contains the user's ID (this will be the username portion of the JID)
      namefield     = 'cn',                                          -- The field that contains the user's full name (this will be the alias found in the roster)
    },

    groups = {
      basedn      = '{{LDAP_GROUP_BASE}}',     -- The base DN where group records can be found
      memberfield = 'member',                      -- The field that contains user ID records for this group (each member must have a corresponding entry under the user basedn with the same value in usernamefield)
      namefield   = 'cn',                          -- The field that contains the group's name (used for matching groups in LDAP to group definitions below)

      {
        name  = '{{LDAP_GROUP}}',   -- The group name that will be seen in users' rosters
        cn    = '{{LDAP_GROUP}}',   -- This field's key *must* match ldap.groups.namefield! It's the name of the LDAP group this definition represents
        admin = false,              -- (Optional) A boolean flag that indicates whether members of this group should be considered administrators.
      },
      {
        name  = 'xmpp_admins',
        cn    = 'xmpp_admins',
        admin = true,
      },
    },

    vcard_format = {
      displayname = 'cn', -- Consult the vCard configuration section in the README
      nickname    = 'uid',
      name        = {
        family = 'sn',
        given  = 'givenName',
      },
      photo       = {
        type   = 'image/jpeg',
        binval = 'jpegPhoto',
      },
      telephone = {
       home = {
			   voice = true,
         number = 'telephoneNumber',
        },
       mobile = {
			   voice = true,
         number = 'mobile',
        }
      },
      address = {
       home = {
         street = 'street', -- street name
         pcode = 'postalCode', -- postal code
         locality = 'l', -- city name
         region = 'st', -- state name
        }
      },
      email = {
       home = {
         userid = 'mail',
        }
     },
    },
}
