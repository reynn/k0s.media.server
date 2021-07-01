use crate::Porkbun;

use anyhow::Result;
use async_trait::async_trait;
use serde::{Deserialize, Serialize};
use serde_json::json;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub enum DnsRecordType {
    A,
    MX,
    CNAME,
    ALIAS,
    TXT,
    NS,
    AAAA,
    SRV,
    TLSA,
    CAA,
}

impl From<String> for DnsRecordType {
    fn from(s: String) -> Self {
        match s.to_lowercase().as_str() {
            "a" => Self::A,
            "mx" => Self::MX,
            "cname" => Self::CNAME,
            "alias" => Self::ALIAS,
            "txt" => Self::TXT,
            "ns" => Self::NS,
            "aaaa" => Self::AAAA,
            "srv" => Self::SRV,
            "tlsa" => Self::TLSA,
            "caa" => Self::CAA,
            _ => panic!("{} is not a valid record type", s),
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DnsRecord {
    id: String,
    name: String,
    #[serde(rename = "type")]
    record_type: String,
    content: String,
    ttl: String,
    prio: Option<String>,
    notes: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PorkbunGetDnsResult {
    pub status: String,
    pub records: Vec<DnsRecord>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PorkbunCreateDnsResult {
    pub status: String,
    pub id: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PorkbunDeleteDnsResult {
    pub status: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PorkbunEditDnsResult {
    pub status: String,
}

#[async_trait]
pub trait PorkbunDnsV3 {
    async fn create_dns_record(
        &self,
        domain: &str,
        name: &str,
        record_type: Option<&DnsRecordType>,
        content: Option<&str>,
        ttl: Option<&str>,
    ) -> Result<PorkbunCreateDnsResult>;
    async fn edit_dns_record(
        &self,
        domain: &str,
        name: &str,
        record_id: &str,
        record_type: Option<&DnsRecordType>,
        content: Option<&str>,
        ttl: Option<&str>,
    ) -> Result<PorkbunEditDnsResult>;
    async fn delete_dns_record(
        &self,
        domain: &str,
        record_id: &str,
    ) -> Result<PorkbunDeleteDnsResult>;
    async fn get_dns_records(&self, domain: &str) -> Result<PorkbunGetDnsResult>;
}

#[async_trait]
impl PorkbunDnsV3 for Porkbun {
    async fn create_dns_record(
        &self,
        domain: &str,
        name: &str,
        record_type: Option<&DnsRecordType>,
        content: Option<&str>,
        ttl: Option<&str>,
    ) -> Result<PorkbunCreateDnsResult> {
        Ok(reqwest::Client::new()
            .post(format!("{}/dns/create/{}", self.base_url, domain))
            .json(&json!({"secretapikey": self.secret_key,
              "apikey": self.api_key,
              "name": name,
              "type": record_type,
              "content": content,
              "ttl": ttl.unwrap_or("300"),
            }))
            .send()
            .await?
            .json()
            .await?)
    }

    async fn edit_dns_record(
        &self,
        domain: &str,
        name: &str,
        record_id: &str,
        record_type: Option<&DnsRecordType>,
        content: Option<&str>,
        ttl: Option<&str>,
    ) -> Result<PorkbunEditDnsResult> {
        Ok(reqwest::Client::new()
            .post(format!(
                "{}/dns/edit/{}/{}",
                self.base_url, domain, record_id
            ))
            .json(&json!({
              "apikey": self.api_key,
              "secretapikey": self.secret_key,
              "name": name,
              "type": record_type,
              "content": content,
              "ttl": ttl.unwrap_or("300"),
            }))
            .send()
            .await?
            .json()
            .await?)
    }

    async fn delete_dns_record(
        &self,
        domain: &str,
        record_id: &str,
    ) -> Result<PorkbunDeleteDnsResult> {
        Ok(reqwest::Client::new()
            .post(format!(
                "{}/dns/delete/{}/{}",
                self.base_url, domain, record_id
            ))
            .json(&json!({
              "apikey": self.api_key,
              "secretapikey": self.secret_key,
            }))
            .send()
            .await?
            .json()
            .await?)
    }

    async fn get_dns_records(&self, domain: &str) -> Result<PorkbunGetDnsResult> {
        Ok(reqwest::Client::new()
            .post(format!("{}/dns/retrieve/{}", self.base_url, domain))
            .json(&json!({
              "apikey": self.api_key,
              "secretapikey": self.secret_key,
            }))
            .send()
            .await?
            .json()
            .await?)
    }
}
