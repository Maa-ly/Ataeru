//SPDX-License_Identifier: MIT
pragma solidity 0.8.26; 

lib Structs{
    struct DonorInfo{
        string name;
        string email;
        string bloodGroup;
        string location;
        uint age;
        uint weight;
        uint height;
        uint contact;
        string about;
        bytes32 witnessHash; // health document hash
        bool isDonor;
        DonorType donorType;
    }

    enum DonorType{
        SPERMDONOR,
        EGGDONOR,
        SURROGATE
    }

    struct UserInfo{
        string name;
        string email;
        string location;
        uint contact;
        string about;
        bytes32 witnessHash; // health document hash
        bool isUser;
        bool isSurrogateReceiver;
        bool isEggReceiver;
        bool isSpermReceiver;
    }

    struct HospitalInfo{
        string name;
        string email;
        string location;
        uint contact;
        string about;
        bytes32 witnessHash; // health document hash
        bool isHospital;
    }

    struct DonorSet{
        address hospital;
        address donor;
          bool isregisterset;
    }

    struct UserSet{
        address hospital;
        address user;
        bool isregisterset;
    }
    
    struct AgentInfo{
    string nameOfAgent;
    string description;
    uint256 nftId;
    bool isDeployedAgent;
    ActivityConfinment activity;
    AgentStatus status;
   }
   enum AgentStatus{
       PENDING,
       DEPLOYED
   }

   enum ActivityConfinment{
    NONE,
    BOOKING,
    FULL,
    VERIFYAUTHENTICITY,
    
   }

}