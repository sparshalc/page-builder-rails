# db/seeds.rb

# Clear existing data (optional - comment out if you want to keep existing data)
PageComponent.destroy_all
Page.destroy_all
Component.destroy_all

puts "Creating components..."

# Hero Components
Component.create!(
  name: "Hero Banner",
  component_type: "hero",
  html_content: <<~HTML,
    <div class="hero-section" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 4rem 2rem; text-align: center; color: white; border-radius: 0.5rem;">
      <h1 style="font-size: 3rem; margin-bottom: 1rem; font-weight: bold;">{{title}}</h1>
      <p style="font-size: 1.25rem; margin-bottom: 2rem; opacity: 0.9;">{{subtitle}}</p>
      <a href="{{button_link}}" style="background: white; color: #667eea; padding: 0.75rem 2rem; text-decoration: none; border-radius: 0.25rem; font-weight: 600; display: inline-block; transition: transform 0.2s;">{{button_text}}</a>
    </div>
  HTML
  properties: {
    title: "Welcome to Your Site",
    subtitle: "Build beautiful pages with drag and drop",
    button_text: "Get Started",
    button_link: "#"
  }
)

Component.create!(
  name: "Hero with Image",
  component_type: "hero",
  html_content: <<~HTML,
    <div class="hero-with-image" style="display: flex; align-items: center; min-height: 500px; padding: 2rem; gap: 3rem;">
      <div style="flex: 1;">
        <h1 style="font-size: 2.5rem; margin-bottom: 1rem; color: #1f2937;">{{title}}</h1>
        <p style="font-size: 1.125rem; color: #6b7280; margin-bottom: 2rem; line-height: 1.6;">{{description}}</p>
        <div style="display: flex; gap: 1rem;">
          <a href="{{primary_button_link}}" style="background: #3b82f6; color: white; padding: 0.75rem 1.5rem; text-decoration: none; border-radius: 0.375rem; font-weight: 500;">{{primary_button_text}}</a>
          <a href="{{secondary_button_link}}" style="background: white; color: #3b82f6; padding: 0.75rem 1.5rem; text-decoration: none; border-radius: 0.375rem; border: 1px solid #3b82f6; font-weight: 500;">{{secondary_button_text}}</a>
        </div>
      </div>
      <div style="flex: 1;">
        <img src="{{image_url}}" alt="{{image_alt}}" style="width: 100%; height: auto; border-radius: 0.5rem; box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);">
      </div>
    </div>
  HTML
  properties: {
    title: "Boost Your Productivity",
    description: "Our platform helps you build amazing websites faster than ever before. Drag, drop, and deploy in minutes.",
    primary_button_text: "Start Free Trial",
    primary_button_link: "#",
    secondary_button_text: "Learn More",
    secondary_button_link: "#",
    image_url: "https://via.placeholder.com/600x400",
    image_alt: "Hero image"
  }
)

# Header Components
Component.create!(
  name: "Navigation Header",
  component_type: "header",
  html_content: <<~HTML,
    <header style="background: white; box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1); padding: 1rem 2rem;">
      <nav style="display: flex; justify-content: space-between; align-items: center; max-width: 1200px; margin: 0 auto;">
        <div style="font-size: 1.5rem; font-weight: bold; color: #1f2937;">{{logo_text}}</div>
        <ul style="display: flex; list-style: none; gap: 2rem; margin: 0; padding: 0;">
          <li><a href="{{nav_link_1}}" style="color: #4b5563; text-decoration: none; font-weight: 500;">{{nav_text_1}}</a></li>
          <li><a href="{{nav_link_2}}" style="color: #4b5563; text-decoration: none; font-weight: 500;">{{nav_text_2}}</a></li>
          <li><a href="{{nav_link_3}}" style="color: #4b5563; text-decoration: none; font-weight: 500;">{{nav_text_3}}</a></li>
          <li><a href="{{nav_link_4}}" style="color: #4b5563; text-decoration: none; font-weight: 500;">{{nav_text_4}}</a></li>
        </ul>
        <a href="{{cta_link}}" style="background: #3b82f6; color: white; padding: 0.5rem 1rem; text-decoration: none; border-radius: 0.375rem; font-weight: 500;">{{cta_text}}</a>
      </nav>
    </header>
  HTML
  properties: {
    logo_text: "YourLogo",
    nav_text_1: "Home",
    nav_link_1: "/",
    nav_text_2: "Features",
    nav_link_2: "#features",
    nav_text_3: "Pricing",
    nav_link_3: "#pricing",
    nav_text_4: "Contact",
    nav_link_4: "#contact",
    cta_text: "Get Started",
    cta_link: "#signup"
  }
)

# Text Components
Component.create!(
  name: "Text Block",
  component_type: "text",
  html_content: <<~HTML,
    <div class="text-block" style="padding: 2rem; max-width: 800px; margin: 0 auto;">
      <h2 style="margin-bottom: 1rem; color: #1f2937; font-size: 2rem;">{{heading}}</h2>
      <p style="line-height: 1.6; color: #4b5563;">{{content}}</p>
    </div>
  HTML
  properties: {
    heading: "Section Title",
    content: "Your content goes here. This is a flexible text component that can be used for various content sections throughout your page."
  }
)

Component.create!(
  name: "Two Column Text",
  component_type: "text",
  html_content: <<~HTML,
    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 3rem; padding: 3rem 2rem; max-width: 1200px; margin: 0 auto;">
      <div>
        <h3 style="margin-bottom: 1rem; color: #1f2937; font-size: 1.5rem;">{{left_heading}}</h3>
        <p style="line-height: 1.6; color: #4b5563;">{{left_content}}</p>
      </div>
      <div>
        <h3 style="margin-bottom: 1rem; color: #1f2937; font-size: 1.5rem;">{{right_heading}}</h3>
        <p style="line-height: 1.6; color: #4b5563;">{{right_content}}</p>
      </div>
    </div>
  HTML
  properties: {
    left_heading: "First Column",
    left_content: "Content for the left column goes here. You can add any text you want.",
    right_heading: "Second Column",
    right_content: "Content for the right column goes here. Perfect for comparing features or concepts."
  }
)

# Card Components
Component.create!(
  name: "Feature Card",
  component_type: "card",
  html_content: <<~HTML,
    <div style="border: 1px solid #e5e7eb; border-radius: 0.5rem; padding: 1.5rem; margin: 1rem; background: white; box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);">
      <div style="width: 3rem; height: 3rem; background: #eff6ff; border-radius: 0.375rem; display: flex; align-items: center; justify-content: center; margin-bottom: 1rem;">
        <span style="font-size: 1.5rem;">{{icon}}</span>
      </div>
      <h3 style="margin-bottom: 0.5rem; color: #1f2937; font-size: 1.25rem;">{{title}}</h3>
      <p style="color: #6b7280; line-height: 1.5;">{{description}}</p>
    </div>
  HTML
  properties: {
    icon: "🚀",
    title: "Feature Title",
    description: "Describe your feature here. Keep it concise and focused on the value it provides."
  }
)

Component.create!(
  name: "Pricing Card",
  component_type: "card",
  html_content: <<~HTML,
    <div style="border: 2px solid #e5e7eb; border-radius: 0.5rem; padding: 2rem; text-align: center; background: white;">
      <h3 style="font-size: 1.5rem; margin-bottom: 0.5rem; color: #1f2937;">{{plan_name}}</h3>
      <div style="margin: 1.5rem 0;">
        <span style="font-size: 3rem; font-weight: bold; color: #1f2937;">{{price}}</span>
        <span style="color: #6b7280;">{{price_period}}</span>
      </div>
      <ul style="list-style: none; padding: 0; margin: 1.5rem 0; text-align: left;">
        <li style="padding: 0.5rem 0; color: #4b5563;">✓ {{feature_1}}</li>
        <li style="padding: 0.5rem 0; color: #4b5563;">✓ {{feature_2}}</li>
        <li style="padding: 0.5rem 0; color: #4b5563;">✓ {{feature_3}}</li>
        <li style="padding: 0.5rem 0; color: #4b5563;">✓ {{feature_4}}</li>
      </ul>
      <a href="{{cta_link}}" style="display: block; background: #3b82f6; color: white; padding: 0.75rem; text-decoration: none; border-radius: 0.375rem; font-weight: 600;">{{cta_text}}</a>
    </div>
  HTML
  properties: {
    plan_name: "Professional",
    price: "$29",
    price_period: "/month",
    feature_1: "Unlimited projects",
    feature_2: "Priority support",
    feature_3: "Advanced analytics",
    feature_4: "Custom integrations",
    cta_text: "Get Started",
    cta_link: "#"
  }
)

Component.create!(
  name: "Testimonial Card",
  component_type: "card",
  html_content: <<~HTML,
    <div style="background: #f9fafb; border-radius: 0.5rem; padding: 2rem; position: relative;">
      <div style="font-size: 3rem; color: #e5e7eb; position: absolute; top: 1rem; left: 1rem;">"</div>
      <p style="font-style: italic; color: #4b5563; margin-bottom: 1.5rem; position: relative; z-index: 1;">{{testimonial_text}}</p>
      <div style="display: flex; align-items: center; gap: 1rem;">
        <img src="{{author_image}}" alt="{{author_name}}" style="width: 3rem; height: 3rem; border-radius: 50%; object-fit: cover;">
        <div>
          <div style="font-weight: 600; color: #1f2937;">{{author_name}}</div>
          <div style="font-size: 0.875rem; color: #6b7280;">{{author_title}}</div>
        </div>
      </div>
    </div>
  HTML
  properties: {
    testimonial_text: "This product has completely transformed how we work. The intuitive interface and powerful features have saved us countless hours.",
    author_name: "Jane Doe",
    author_title: "CEO, TechCorp",
    author_image: "https://via.placeholder.com/150"
  }
)

# Image Components
Component.create!(
  name: "Image with Caption",
  component_type: "image",
  html_content: <<~HTML,
    <figure style="margin: 2rem 0;">
      <img src="{{image_url}}" alt="{{image_alt}}" style="width: 100%; height: auto; border-radius: 0.5rem;">
      <figcaption style="text-align: center; color: #6b7280; font-size: 0.875rem; margin-top: 0.5rem;">{{caption}}</figcaption>
    </figure>
  HTML
  properties: {
    image_url: "https://via.placeholder.com/800x400",
    image_alt: "Descriptive image text",
    caption: "Image caption goes here"
  }
)

Component.create!(
  name: "Image Grid",
  component_type: "gallery",
  html_content: <<~HTML,
    <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 1rem; padding: 2rem;">
      <img src="{{image_1}}" alt="Image 1" style="width: 100%; height: 200px; object-fit: cover; border-radius: 0.375rem;">
      <img src="{{image_2}}" alt="Image 2" style="width: 100%; height: 200px; object-fit: cover; border-radius: 0.375rem;">
      <img src="{{image_3}}" alt="Image 3" style="width: 100%; height: 200px; object-fit: cover; border-radius: 0.375rem;">
      <img src="{{image_4}}" alt="Image 4" style="width: 100%; height: 200px; object-fit: cover; border-radius: 0.375rem;">
      <img src="{{image_5}}" alt="Image 5" style="width: 100%; height: 200px; object-fit: cover; border-radius: 0.375rem;">
      <img src="{{image_6}}" alt="Image 6" style="width: 100%; height: 200px; object-fit: cover; border-radius: 0.375rem;">
    </div>
  HTML
  properties: {
    image_1: "https://via.placeholder.com/300x200",
    image_2: "https://via.placeholder.com/300x200",
    image_3: "https://via.placeholder.com/300x200",
    image_4: "https://via.placeholder.com/300x200",
    image_5: "https://via.placeholder.com/300x200",
    image_6: "https://via.placeholder.com/300x200"
  }
)

# Button Components
Component.create!(
  name: "Button Group",
  component_type: "button",
  html_content: <<~HTML,
    <div style="display: flex; gap: 1rem; justify-content: center; padding: 2rem;">
      <a href="{{primary_link}}" style="background: #3b82f6; color: white; padding: 0.75rem 1.5rem; text-decoration: none; border-radius: 0.375rem; font-weight: 500; display: inline-block;">{{primary_text}}</a>
      <a href="{{secondary_link}}" style="background: white; color: #3b82f6; padding: 0.75rem 1.5rem; text-decoration: none; border-radius: 0.375rem; border: 1px solid #3b82f6; font-weight: 500; display: inline-block;">{{secondary_text}}</a>
    </div>
  HTML
  properties: {
    primary_text: "Primary Action",
    primary_link: "#",
    secondary_text: "Secondary Action",
    secondary_link: "#"
  }
)

Component.create!(
  name: "CTA Button",
  component_type: "button",
  html_content: <<~HTML,
    <div style="text-align: center; padding: 3rem; background: #f3f4f6; border-radius: 0.5rem;">
      <h3 style="font-size: 1.875rem; margin-bottom: 1rem; color: #1f2937;">{{heading}}</h3>
      <p style="color: #6b7280; margin-bottom: 2rem; max-width: 600px; margin-left: auto; margin-right: auto;">{{subheading}}</p>
      <a href="{{button_link}}" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 1rem 2rem; text-decoration: none; border-radius: 0.375rem; font-weight: 600; display: inline-block; font-size: 1.125rem;">{{button_text}}</a>
    </div>
  HTML
  properties: {
    heading: "Ready to get started?",
    subheading: "Join thousands of satisfied customers using our platform.",
    button_text: "Start Your Free Trial",
    button_link: "#"
  }
)

# Footer Components
Component.create!(
  name: "Simple Footer",
  component_type: "footer",
  html_content: <<~HTML,
    <footer style="background: #1f2937; color: white; padding: 3rem 2rem; text-align: center;">
      <div style="max-width: 1200px; margin: 0 auto;">
        <div style="font-size: 1.5rem; font-weight: bold; margin-bottom: 1rem;">{{company_name}}</div>
        <div style="display: flex; justify-content: center; gap: 2rem; margin-bottom: 2rem;">
          <a href="{{link_1}}" style="color: #9ca3af; text-decoration: none;">{{link_text_1}}</a>
          <a href="{{link_2}}" style="color: #9ca3af; text-decoration: none;">{{link_text_2}}</a>
          <a href="{{link_3}}" style="color: #9ca3af; text-decoration: none;">{{link_text_3}}</a>
          <a href="{{link_4}}" style="color: #9ca3af; text-decoration: none;">{{link_text_4}}</a>
        </div>
        <div style="color: #6b7280; font-size: 0.875rem;">{{copyright_text}}</div>
      </div>
    </footer>
  HTML
  properties: {
    company_name: "Your Company",
    link_text_1: "Privacy Policy",
    link_1: "/privacy",
    link_text_2: "Terms of Service",
    link_2: "/terms",
    link_text_3: "Contact",
    link_3: "/contact",
    link_text_4: "About",
    link_4: "/about",
    copyright_text: "© 2024 Your Company. All rights reserved."
  }
)

Component.create!(
  name: "Footer with Columns",
  component_type: "footer",
  html_content: <<~HTML,
    <footer style="background: #f9fafb; padding: 4rem 2rem; border-top: 1px solid #e5e7eb;">
      <div style="max-width: 1200px; margin: 0 auto; display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 3rem;">
        <div>
          <div style="font-size: 1.5rem; font-weight: bold; color: #1f2937; margin-bottom: 1rem;">{{brand_name}}</div>
          <p style="color: #6b7280; line-height: 1.6;">{{brand_description}}</p>
        </div>
        <div>
          <h4 style="font-weight: 600; color: #1f2937; margin-bottom: 1rem;">{{column_1_title}}</h4>
          <ul style="list-style: none; padding: 0;">
            <li style="margin-bottom: 0.5rem;"><a href="#" style="color: #6b7280; text-decoration: none;">{{column_1_link_1}}</a></li>
            <li style="margin-bottom: 0.5rem;"><a href="#" style="color: #6b7280; text-decoration: none;">{{column_1_link_2}}</a></li>
            <li style="margin-bottom: 0.5rem;"><a href="#" style="color: #6b7280; text-decoration: none;">{{column_1_link_3}}</a></li>
          </ul>
        </div>
        <div>
          <h4 style="font-weight: 600; color: #1f2937; margin-bottom: 1rem;">{{column_2_title}}</h4>
          <ul style="list-style: none; padding: 0;">
            <li style="margin-bottom: 0.5rem;"><a href="#" style="color: #6b7280; text-decoration: none;">{{column_2_link_1}}</a></li>
            <li style="margin-bottom: 0.5rem;"><a href="#" style="color: #6b7280; text-decoration: none;">{{column_2_link_2}}</a></li>
            <li style="margin-bottom: 0.5rem;"><a href="#" style="color: #6b7280; text-decoration: none;">{{column_2_link_3}}</a></li>
          </ul>
        </div>
        <div>
          <h4 style="font-weight: 600; color: #1f2937; margin-bottom: 1rem;">{{column_3_title}}</h4>
          <ul style="list-style: none; padding: 0;">
            <li style="margin-bottom: 0.5rem;"><a href="#" style="color: #6b7280; text-decoration: none;">{{column_3_link_1}}</a></li>
            <li style="margin-bottom: 0.5rem;"><a href="#" style="color: #6b7280; text-decoration: none;">{{column_3_link_2}}</a></li>
            <li style="margin-bottom: 0.5rem;"><a href="#" style="color: #6b7280; text-decoration: none;">{{column_3_link_3}}</a></li>
          </ul>
        </div>
      </div>
    </footer>
  HTML
  properties: {
    brand_name: "YourBrand",
    brand_description: "Building the future of web development with innovative tools and solutions.",
    column_1_title: "Product",
    column_1_link_1: "Features",
    column_1_link_2: "Pricing",
    column_1_link_3: "FAQ",
    column_2_title: "Company",
    column_2_link_1: "About",
    column_2_link_2: "Blog",
    column_2_link_3: "Careers",
    column_3_title: "Support",
    column_3_link_1: "Contact",
    column_3_link_2: "Documentation",
    column_3_link_3: "Help Center"
  }
)

puts "Created #{Component.count} components!"

# Create sample pages
puts "Creating sample pages..."

# Landing Page
landing_page = Page.create!(
  title: "Sample Landing Page",
  published: true
)

# Add components to landing page
[
  Component.find_by(name: "Navigation Header"),
  Component.find_by(name: "Hero Banner"),
  Component.find_by(name: "Text Block"),
  Component.find_by(name: "Feature Card"),
  Component.find_by(name: "CTA Button"),
  Component.find_by(name: "Simple Footer")
].compact.each_with_index do |component, index|
  landing_page.page_components.create!(
    component: component,
    position: index + 1
  )
end

# About Page
about_page = Page.create!(
  title: "About Us",
  published: true
)

# Add components to about page
[
  Component.find_by(name: "Navigation Header"),
  Component.find_by(name: "Hero with Image"),
  Component.find_by(name: "Two Column Text"),
  Component.find_by(name: "Testimonial Card"),
  Component.find_by(name: "Footer with Columns")
].compact.each_with_index do |component, index|
  about_page.page_components.create!(
    component: component,
    position: index + 1
  )
end

puts "Created #{Page.count} pages!"
puts "Seeding completed!"
