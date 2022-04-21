use globwalk::glob_builder;
use tera::Tera;

fn main() {
    println!("Starting");

    for entry in glob_builder("templates/**/*")
        .follow_links(true)
        .build()
        .unwrap()
        .filter_map(std::result::Result::ok)
    {
        let path = entry.into_path();

        if path.is_file() {
            println!("File found");
        }
    }

    println!("All files searched");

    let tera = Tera::new("templates/**/*");

    println!("Finished");
}