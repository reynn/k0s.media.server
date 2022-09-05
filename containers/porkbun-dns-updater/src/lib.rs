pub mod cli;
pub mod dns;

pub use crate::{cli::*, dns::*};
use anyhow::*;
use reqwest::Client;
use serde::{Deserialize, Serialize};
use serde_json::json;
use url::Url;

#[derive(Debug, Clone)]
pub struct Porkbun {
    base_url: Url,
    api_key: String,
    secret_key: String,
    client: Client,
    current_ip: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct PorkbunPingResponse {
    pub status: String,
    pub your_ip: String,
}

impl Porkbun {
    pub async fn new<S: Into<String>>(
        api_key: S,
        secret_key: S,
        client: Option<Client>,
    ) -> Result<Self> {
        let url = Url::parse("https://porkbun.com/api/json/v3")?;
        let mut s = Self {
            base_url: url,
            api_key: api_key.into(),
            secret_key: secret_key.into(),
            current_ip: None,
            client: client.unwrap_or_default(),
        };
        let ping_response = &s.ping().await?;
        if ping_response.status == "success" {
            s.current_ip = Some(String::from(&ping_response.your_ip))
        };
        Ok(s)
    }

    async fn ping(&self) -> Result<PorkbunPingResponse> {
        let endpoint = format!("{}/ping", self.base_url);
        Ok(self
            .client
            .post(endpoint)
            .json(&json!({
              "apikey": self.api_key,
              "secretapikey": self.secret_key,
            }))
            .send()
            .await?
            .json()
            .await?)
    }
    //
    // pub fn base_url<'a, S: Into<&'a str>>(&mut self, base_url: S) -> Result<Self> {
    // Ok(*self)
    // }
}
