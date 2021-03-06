{-# LANGUAGE BangPatterns         #-}
{-# LANGUAGE DeriveGeneric        #-}
{-# LANGUAGE DeriveAnyClass       #-}
{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE RecordWildCards      #-}
{-# LANGUAGE ExplicitForAll       #-}
{-# LANGUAGE RankNTypes           #-}
{-# LANGUAGE ScopedTypeVariables  #-}

module LN.T.Pack.TeamMember where


import LN.T.TeamMember
import LN.T.User
import LN.T.Permission


import           Control.DeepSeq             (NFData)
import           Data.Aeson                  (FromJSON, ToJSON (), Value (..), parseJSON, toJSON, object, (.=), (.:))
import           Data.Default                (Default, def)
import           Data.Int                    (Int64)
import           Data.Text                   (Text)
import qualified Data.Text                   as T
import           Data.Time                   (UTCTime)
import           Data.Typeable               (Typeable)
import           Data.Monoid                 ((<>))
import           GHC.Generics                (Generic)
import           Haskell.Api.Helpers.Shared  (QueryParam, qp)
import           Prelude

data TeamMemberPackResponse = TeamMemberPackResponse {
  teamMemberPackResponseUser :: !(UserSanitizedResponse),
  teamMemberPackResponseUserId :: !(Int64),
  teamMemberPackResponseTeamMember :: !(TeamMemberResponse),
  teamMemberPackResponseTeamMemberId :: !(Int64),
  teamMemberPackResponsePermissions :: !(Permissions)
}  deriving (Generic,Typeable,NFData)


instance FromJSON TeamMemberPackResponse where
  parseJSON (Object o) = do
    teamMemberPackResponseUser <- o .: ("user" :: Text)
    teamMemberPackResponseUserId <- o .: ("user_id" :: Text)
    teamMemberPackResponseTeamMember <- o .: ("team_member" :: Text)
    teamMemberPackResponseTeamMemberId <- o .: ("team_member_id" :: Text)
    teamMemberPackResponsePermissions <- o .: ("permissions" :: Text)
    pure $ TeamMemberPackResponse {
      teamMemberPackResponseUser = teamMemberPackResponseUser,
      teamMemberPackResponseUserId = teamMemberPackResponseUserId,
      teamMemberPackResponseTeamMember = teamMemberPackResponseTeamMember,
      teamMemberPackResponseTeamMemberId = teamMemberPackResponseTeamMemberId,
      teamMemberPackResponsePermissions = teamMemberPackResponsePermissions
    }
  parseJSON x = fail $ "Could not parse object: " <> show x


instance ToJSON TeamMemberPackResponse where
  toJSON TeamMemberPackResponse{..} = object $
    [ "tag" .= ("TeamMemberPackResponse" :: Text)
    , "user" .= teamMemberPackResponseUser
    , "user_id" .= teamMemberPackResponseUserId
    , "team_member" .= teamMemberPackResponseTeamMember
    , "team_member_id" .= teamMemberPackResponseTeamMemberId
    , "permissions" .= teamMemberPackResponsePermissions
    ]


instance Eq TeamMemberPackResponse where
  (==) a b = teamMemberPackResponseUser a == teamMemberPackResponseUser b && teamMemberPackResponseUserId a == teamMemberPackResponseUserId b && teamMemberPackResponseTeamMember a == teamMemberPackResponseTeamMember b && teamMemberPackResponseTeamMemberId a == teamMemberPackResponseTeamMemberId b && teamMemberPackResponsePermissions a == teamMemberPackResponsePermissions b

instance Show TeamMemberPackResponse where
    show rec = "teamMemberPackResponseUser: " <> show (teamMemberPackResponseUser rec) <> ", " <> "teamMemberPackResponseUserId: " <> show (teamMemberPackResponseUserId rec) <> ", " <> "teamMemberPackResponseTeamMember: " <> show (teamMemberPackResponseTeamMember rec) <> ", " <> "teamMemberPackResponseTeamMemberId: " <> show (teamMemberPackResponseTeamMemberId rec) <> ", " <> "teamMemberPackResponsePermissions: " <> show (teamMemberPackResponsePermissions rec)

data TeamMemberPackResponses = TeamMemberPackResponses {
  teamMemberPackResponses :: !([TeamMemberPackResponse])
}  deriving (Generic,Typeable,NFData)


instance FromJSON TeamMemberPackResponses where
  parseJSON (Object o) = do
    teamMemberPackResponses <- o .: ("team_member_pack_responses" :: Text)
    pure $ TeamMemberPackResponses {
      teamMemberPackResponses = teamMemberPackResponses
    }
  parseJSON x = fail $ "Could not parse object: " <> show x


instance ToJSON TeamMemberPackResponses where
  toJSON TeamMemberPackResponses{..} = object $
    [ "tag" .= ("TeamMemberPackResponses" :: Text)
    , "team_member_pack_responses" .= teamMemberPackResponses
    ]


instance Eq TeamMemberPackResponses where
  (==) a b = teamMemberPackResponses a == teamMemberPackResponses b

instance Show TeamMemberPackResponses where
    show rec = "teamMemberPackResponses: " <> show (teamMemberPackResponses rec)
-- footer