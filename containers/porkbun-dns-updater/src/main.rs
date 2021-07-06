use anyhow::Result;
use log::*;
use porkbun_cli::cli::Cli;
use porkbun_cli::*;
use simplelog::*;

#[tokio::main]
async fn main() -> Result<()> {
    let cli = Cli::new()?;

    CombinedLogger::init(vec![TermLogger::new(
        if cli.verbose {
            LevelFilter::Debug
        } else {
            LevelFilter::Info
        },
        Config::default(),
        TerminalMode::Mixed,
        ColorChoice::Auto,
    )])
    .unwrap();

    let porkbun_client = Porkbun::new(&cli.api_key, &cli.secret_key, None).await?;

    if let Some(subcommand) = cli.subcommand {
        let domain = &cli.domain;
        match subcommand {
            Subcommands::Create {
                name,
                record_type,
                content,
                ttl,
            } => {
                info!("Creating {} in the {} domain", name, domain);
                let response = porkbun_client
                    .create_dns_record(
                        &domain,
                        &name,
                        Some(&record_type.into()),
                        Some(&content),
                        Some(&ttl),
                    )
                    .await?;
                info!("Create response {:?}", response);
            }
            Subcommands::Edit {
                record_id,
                name,
                record_type,
                content,
                ttl,
            } => {
                info!("Editing {} in the {} domain", record_id, domain);
                porkbun_client
                    .edit_dns_record(
                        domain,
                        &name,
                        &record_id,
                        Some(&record_type.into()),
                        Some(&content),
                        Some(&ttl),
                    )
                    .await?;
            }
            Subcommands::Delete { record_id } => {
                info!("Deleting {} from {}", record_id, domain);
                let response = porkbun_client
                    .delete_dns_record(&domain, &record_id)
                    .await?;
                info!("Delete response: {:?}", response);
            }
            Subcommands::Get => {
                info!("Getting records for the {} domain", domain);
                let response = porkbun_client.get_dns_records(&domain).await?;
                let records = response.records;
                info!(
                    "There are {} records in the {} domain",
                    records.len(),
                    domain
                );
                for record in records.into_iter() {
                    info!("{:?}", record)
                }
            }
            Subcommands::Completions { shell } => info!("Generating completions for {}", shell),
        }
    }

    info!("---------------- Completed ----------------");

    Ok(())
}
