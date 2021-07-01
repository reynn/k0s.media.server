use anyhow::Result;
pub use structopt::StructOpt;

#[derive(Debug, Clone, StructOpt)]
#[structopt(name = "porkbun")]
pub struct Cli {
    /// API Key for Porkbun, retrieve or create from https://porkbun.com/account/api
    #[structopt(short, long)]
    pub api_key: String,
    /// Secret API Key for Porkbun, retrieve or create from https://porkbun.com/account/api
    #[structopt(short, long)]
    pub secret_key: String,
    /// The domain to interact with, eg. example.com
    #[structopt(short, long)]
    pub domain: String,
    /// Set the logging level to debug for additional information
    #[structopt(short, long, global = true)]
    pub verbose: bool,
    #[structopt(subcommand)]
    pub subcommand: Option<Subcommands>,
}

impl Cli {
    pub fn new() -> Result<Cli> {
        Ok(Cli::from_args())
    }
}

#[derive(Debug, Clone, StructOpt)]
pub enum Subcommands {
    /// Create a new record for the provided DNS
    Create {
        name: String,
        record_type: String,
        content: String,
        ttl: String,
    },
    /// Edit an existing DNS record
    Edit {
        record_id: String,
        name: String,
        record_type: String,
        content: String,
        ttl: String,
    },
    /// Delete a DNS record by ID
    Delete { record_id: String },
    /// Retrieve DNS records for a given domain
    Get,
}
